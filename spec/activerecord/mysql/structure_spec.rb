require 'spec_helper'
require 'active_record'
require 'activerecord-mysql-structure'

describe ActiveRecord::Mysql::Structure do
  it 'has a version number' do
    expect(ActiveRecord::Mysql::Structure::VERSION).not_to be nil
  end

  context 'StructureSqlSanitizer' do
    describe '.sanitize' do
      it 'should remove unwanted lines and substrings from structure.sql' do
        filename = File.join(RSpec::root, 'data', 'structure.example.sql')
        expected_filename = File.join(RSpec::root, 'data', 'structure.expected.sql')

        actual_sanitized_content = ActiveRecordMySqlStructure::StructureSqlSanitizer.sanitize(filename)
        expected_sanitized_content = File.read(expected_filename)
        expect(actual_sanitized_content).to eq(expected_sanitized_content)
      end
    end
  end
end
