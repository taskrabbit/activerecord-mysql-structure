$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'activerecord-mysql-structure'

module ::RSpec
  module_function
  def root
    @spec_root ||= File.expand_path('..', __FILE__)
  end
end

RSpec.configure do |c|
  c.filter_run_excluding :active_record_3 => (ActiveRecord::VERSION::MAJOR != 3)
end
