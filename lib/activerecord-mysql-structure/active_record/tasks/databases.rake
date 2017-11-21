namespace :db do
  # For rails 4 and up
  Rake::Task['db:structure:dump'].enhance do
    filename = ENV['SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'structure.sql')
    File.write(filename, ActiveRecordMySqlStructure::StructureSqlSanitizer.sanitize(filename))
  end if ActiveRecord::VERSION::MAJOR > 3
end
