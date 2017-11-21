require 'active_support'
require 'active_record'
begin
  require 'rails'
rescue LoadError
  # nothing to do! yay!
end

require 'activerecord-mysql-structure/active_record/structure_sql_sanitizer'

if defined? Rails
  require 'activerecord-mysql-structure/railtie'
elsif ActiveRecord::VERSION::MAJOR == 3
  require 'activerecord-mysql-structure/active_record/v3/connection_adapters/abstract_mysql_adapter'
end
