module ActiveRecord
  module Mysql
    module Structure
      class Railtie < Rails::Railtie
        if ActiveRecord::VERSION::MAJOR < 4
          initializer 'activerecord-mysql-structure' do
            ActiveSupport.on_load :active_record do
              require 'activerecord-mysql-structure/active_record/v3/connection_adapters/abstract_mysql_adapter'
            end
          end
        else
          rake_tasks do
            load 'activerecord-mysql-structure/active_record/tasks/databases.rake'
          end
        end
      end
    end
  end
end
