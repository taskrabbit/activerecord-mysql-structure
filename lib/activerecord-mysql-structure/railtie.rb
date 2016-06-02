module ActiveRecord
  module Mysql
    module Structure
      class Railtie < Rails::Railtie
        rake_tasks do
          load 'activerecord-mysql-structure/active_record/tasks/databases.rake'
        end
      end
    end
  end
end
