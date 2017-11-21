# ActiveRecord::Mysql::Structure

This gem improves ActiveRecord's dumping of MySQL schema to a `structure.sql` file.
- `AUTO_INCREMENT` values will not be written, preventing noisy diffs
- comments starting with `--` will not be written
- MySQL `SET` directives starting with `/*` will not be written
- removes extra newline at the bottom of the file

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-mysql-structure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-mysql-structure

For rails projects, there is no additional step; `activerecord-mysql-structure` will hook into your application automagically.
For non-rails projects, you can use the `structure.sql` sanitizing utility manually as follows:

```ruby
sanitized_content = ActiveRecordMySqlStructure::StructureSqlSanitizer.sanitize(path_to_default_structure_sql)
File.write(path_to_sanitized_structure_sql, sanitized_content)
```
