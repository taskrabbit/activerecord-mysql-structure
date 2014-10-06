# ActiveRecord::Mysql::Structure

This gem improves ActiveRecord's dumping of MySQL schema to a `structure.sql` file.
- `AUTO_INCREMENT` values will not be written, preventing noisy diffs
- `DROP TABLE IF EXISTS` statements will be prepended to `CREATE_TABLE` statements, mimicking the `force: true` option normally captured in `schema.rb`

It is intended for use with ActiveRecord 3 only.
The `AUTO_INCREMENT` functionality is unlikely to ever be added to Rails master as it uses the `mysqldump` command directly.
As of this writing, `mysqldump` has no support for ignoring `AUTO_INCREMENT` output.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-mysql-structure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-mysql-structure
