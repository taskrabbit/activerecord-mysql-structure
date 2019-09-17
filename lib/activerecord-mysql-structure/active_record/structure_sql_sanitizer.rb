# frozen_string_literal: true

module ActiveRecordMySqlStructure
  # This module is used by the enhanced rake task to sanitize the structure.sql
  class StructureSqlSanitizer
    COLUMN_REGEX = /\A\s*`\w+`/

    # Naive index check. Covers the most common use-cases
    INDEX_REGEX = /(?<key_definition>\A\s*(?:UNIQUE )?KEY\s+.*?)(?:,?)(?<after_optional_comma>\s*\Z)/

    # Index sanitization currently assumes that each table's engine has a default of USING BTREE;
    # crash if any other engine is in use
    UNSUPPORTED_ENGINE_REGEX = /ENGINE=(?!InnoDB|MyISAM)/

    # Friendly comment warning maintainers that this gem is meddling with the
    # contents of their structure.sql
    DECLARATION_OF_ORIGIN = "-- MySQL Dump modified by gem 'activerecord-mysql-structure'"

    # When set to true, the sanitizer will sort the columns of each table. This
    # will help keep a consistent column order in the outputted structure file.
    # The columns will be sorted alphabetically.
    #
    # @param val [Boolean] the new setting for column sorting
    def self.sorted_columns=(val)
      @sorted_columns = val
    end

    # Returns whether the structure should have alphabetically sorted columns.
    #
    # @return [Boolean] the current setting for column sorting
    def self.sorted_columns?
      @sorted_columns
    end

    # When set to true, the sanitizer will sort the index definitions of each
    # table. This will help keep a consistent index order in the outputted
    # structure file. The indices will be sorted alphabetically, and redundant
    # index_type clauses will be stripped
    #
    # @param val [Boolean] the new setting for index sorting
    def self.sorted_indices=(val)
      @sorted_indices = val
    end

    # Returns whether the structure should have sanitized, alphabetically sorted
    # indices
    #
    # @return [Boolean] the current setting for index sorting
    def self.sorted_indices?
      !!@sorted_indices
    end

    def self.sanitize(filename)
      new(filename, sorted_columns: sorted_columns?, sorted_indices: sorted_indices?).sanitize!
    end

    attr_reader :filename, :sorted_columns, :sorted_indices

    def initialize(filename, sorted_columns:, sorted_indices:)
      @filename = filename
      @sorted_columns = sorted_columns
      @sorted_indices = sorted_indices
    end

    def sanitize!
      lines = load_file
      lines.unshift(DECLARATION_OF_ORIGIN)
      lines = sort_columns(lines) if sorted_columns
      lines = sort_indices(lines) if sorted_indices
      lines = lines.join

      # remove empty lines from the top using lstrip.
      lines.lstrip!

      # remove trailing lines from the bottom.
      lines.chomp!

      lines
    end

    private

    def load_file
      lines = []
      File.readlines(filename).each do |line|
        # get rid of SQL comments and MySQL SET directives.
        next if line.start_with?('--')
        next if line.start_with?('/*!')

        # get rid of AUTO_INCREMENT assignment in CREATE table statements.
        if line.include?('AUTO_INCREMENT=')
          line.gsub!(/\s+AUTO_INCREMENT=\d+\s+/, ' ')
        end

        lines << line
      end
      lines
    end

    def sort_columns(lines)
      cols = []
      on_table = false
      sorted_lines = []

      lines.each do |line|
        if on_table
          if COLUMN_REGEX.match?(line)
            cols << line
          else
            sorted_lines += cols.sort
            sorted_lines << line
            on_table = false
            cols.clear
          end
        else
          sorted_lines << line
        end

        # We know we are parsing a table.
        on_table = true if line.include?('CREATE TABLE')
      end

      sorted_lines
    end

    def sort_indices(lines)
      indices = []
      sorted_lines = []

      lines.each do |line|
        if UNSUPPORTED_ENGINE_REGEX.match?(line)
          raise 'MySQL Structure Sanitizer detected an unsupported engine; aborting'
        end

        match = INDEX_REGEX.match(line)
        if match
          # Ensure trailing commas on each line
          sanitized_index = "#{match[:key_definition]},#{match[:after_optional_comma]}"
          # Remove redundant, noisy default index type specifier
          # TODO: this is not safe on tables using the Memory/Heap nor NDB engines
          indices << sanitized_index.gsub(" USING BTREE", '')
        else
          if indices.size > 0
            sorted_lines += indices.sort
            # Remove the last trailing comma after the sort completes
            sorted_lines[-1] = sorted_lines[-1].gsub(/,(?=\s*\Z)/, '')
            indices.clear
          end

          sorted_lines << line
        end
      end

      sorted_lines
    end
  end
end
