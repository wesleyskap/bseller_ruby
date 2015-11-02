$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler/setup'
require 'bseller_ruby'
require 'pry'
require 'vcr'
require 'webmock'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end


BSELLER_RUBY_CONFIG = YAML.load_file("spec/config.yml")
BsellerRuby.config! 'ws' => BSELLER_RUBY_CONFIG['ws'], 'log' => false
