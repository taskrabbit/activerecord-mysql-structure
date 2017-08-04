require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter < AbstractAdapter
      # Override this to disable FOREIGN_KEY_CHECK at the start of the structure file
      # and re-enable it at the end and to add DROP TABLE IF EXISTS statements to each CREATE TABLE
      def structure_dump #:nodoc:
        if supports_views?
          sql = "SHOW FULL TABLES WHERE Table_type = 'BASE TABLE'"
        else
          sql = "SHOW TABLES"
        end
        # https://lists.mysql.com/announce/166
        # only disable FOREIGN_KEY_CHECK when mysql version is 4.0.14 or later
        structure = "/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;\n\n"
        structure += select_all(sql).map { |table|
          table.delete('Table_type')
          sql = "SHOW CREATE TABLE #{quote_table_name(table.to_a.first.last)}"
          "DROP TABLE IF EXISTS #{quote_table_name(table.to_a.first.last)};\n\n" + exec_query(sql).first['Create Table'] + ";\n\n" # CHANGE 1 of 2 FROM RAILS
        }.join.gsub(/\s+AUTO_INCREMENT=\d+\s+/, ' ') # CHANGE 2 of 2 FROM RAILS
        structure += "/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;\n\n"
        structure
      end

      def dump_schema_information #:nodoc:
        "#{super}\n"
      end
    end
  end
end
