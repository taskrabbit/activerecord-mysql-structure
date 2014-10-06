require 'spec_helper'
require 'active_record'
require 'activerecord-mysql-structure/base'

describe ActiveRecord::Mysql::Structure do
  it 'has a version number' do
    expect(ActiveRecord::Mysql::Structure::VERSION).not_to be nil
  end

  context 'AbstractMysqlAdapter' do
    let(:adapter) { ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.new(nil, nil, nil, prepared_statements: true) }

    describe '#structure_dump' do
      before do
        expect(adapter).to receive(:select_all).with(anything).and_return [{'Tables_in_database' => 'foobar'}]
        expect(adapter).to receive(:structure_dump).and_call_original
        expect(adapter).to receive(:supports_views?).and_return false
        expect(adapter).to receive(:exec_query).and_return [{
          'Create Table' => <<-sql
            CREATE TABLE `foobar` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `some_column` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
              PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=#{(0..1000).to_a.sample} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
          sql
        }]
      end

      it 'adds DROP TABLE IF EXISTS statements' do
        expect(adapter.structure_dump).to include 'DROP TABLE IF EXISTS `foobar`'
      end

      it 'does not include AUTO_INCREMENT value' do
        expect(adapter.structure_dump).not_to include 'AUTO_INCREMENT='
      end

      it 'ends with a newline' do
        expect(adapter.structure_dump.slice(-1)).to eq "\n"
      end
    end

    describe '#dump_schema_information' do
      before do
        expect(adapter).to receive(:select_values).and_return %w(
          20140407202440
          20140407220022
          20140407220125
          20140409230054
          20140424221613
        )
      end

      it 'ends with a newline' do
        expect(adapter.dump_schema_information.slice(-1)).to eq "\n"
      end
    end
  end
end
