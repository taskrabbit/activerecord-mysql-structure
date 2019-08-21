# frozen_string_literal: true

module ActiveRecordMySqlStructure
  # This module is used by the enhanced rake task to sanitize the structure.sql
  class StructureSqlSanitizer
    COLUMN_REGEX = /^\s*`\w+`.*,+$/

    # When set to true, the sanitizer will sort the columns of each table. This
    # will help keep a consistent column order in the outputted structure file.
    # The columns will be sorted alphabetically.
    def self.sorted_columns=(val)
      @sorted_columns = val
    end

    # Returns whether the structure should have alphabetically sorted columns.
    def self.sorted_columns?
      @sorted_columns
    end

    def self.sanitize(filename)
      new(filename, sorted_columns: sorted_columns?).sanitize!
    end

    attr_reader :filename, :sorted_columns

    def initialize(filename, sorted_columns:)
      @filename = filename
      @sorted_columns = sorted_columns
    end

    def sanitize!
      lines = load_file
      lines = sort_columns(lines) if sorted_columns
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
  end
end
