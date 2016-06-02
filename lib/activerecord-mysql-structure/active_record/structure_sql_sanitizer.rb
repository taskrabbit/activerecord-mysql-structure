module ActiveRecordMySqlStructure
  class StructureSqlSanitizer
    def self.sanitize(filename)
      structure_lines = ''
      File.readlines(filename).each do |line|
        # get rid of SQL comments and MySQL SET directives.
        next if line.start_with?('--')
        next if line.start_with?('/*!')

        # get rid of AUTO_INCREMENT assignment in CREATE table statements.
        line.gsub!(/\s+AUTO_INCREMENT=\d+\s+/, ' ') if line.include?('AUTO_INCREMENT=')

        structure_lines << line
      end

      # remove empty lines from the top using lstrip.
      structure_lines.lstrip!

      # remove trailing lines from the bottom.
      structure_lines.chomp!
    end
  end
end
