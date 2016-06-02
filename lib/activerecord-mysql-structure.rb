require 'active_support'

begin
  require 'rails'
rescue LoadError
  # nothing to do! yay!
end

require 'activerecord-mysql-structure/active_record/structure_sql_sanitizer'

if defined? Rails
  require 'activerecord-mysql-structure/railtie'
else
  # nothing to do! yay!
end
