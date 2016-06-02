$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'activerecord-mysql-structure'

module ::RSpec
  module_function
  def root
    @spec_root ||= Pathname.new(__dir__)
  end
end
