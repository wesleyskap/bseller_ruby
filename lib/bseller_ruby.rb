require 'rest-client'
require "savon"
require "bseller_ruby/base"
require "bseller_ruby/response"
require "bseller_ruby/item"
require "bseller_ruby/stock"
require "bseller_ruby/order"
require "bseller_ruby/purchase"
require "bseller_ruby/price"
require "bseller_ruby/tracking"
require "bseller_ruby/delivery"

module BsellerRuby
  def self.config!(config)
    @config = config
  end

  def self.config
    @config
  end
end
