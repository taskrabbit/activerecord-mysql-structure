module ActiveRecord
  module Mysql
    module Structure
      class Railtie < Rails::Railtie
        initializer 'activerecord-mysql-structure' do
          ActiveSupport.on_load :active_record do
            require 'activerecord-mysql-structure/base'
          end
        end
      end
    end
  end
end
