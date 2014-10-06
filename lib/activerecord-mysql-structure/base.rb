if ActiveRecord::VERSION::MAJOR == 3
  require 'activerecord-mysql-structure/active_record/v3/connection_adapters/abstract_mysql_adapter'
else
  raise 'activerecord-mysql-structure supports ActiveRecord version 3 only'
end
