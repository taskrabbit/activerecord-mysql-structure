namespace :db do
  Rake::Task['db:structure:dump'].enhance do
    # grab the filename – the rails way.
    # https://github.com/rails/rails/blob/v4.2.6/activerecord/lib/active_record/railties/databases.rake#L277
    filename = ENV['SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'structure.sql')
    File.write(filename, ActiveRecordMySqlStructure::StructureSqlSanitizer.sanitize(filename))
  end
end
