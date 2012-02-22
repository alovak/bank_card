require 'active_model'
require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/time/calculations'
require 'active_support/i18n'

require "bank_card/version"
require "bank_card/brands"

module BankCard
  module Validations
    extend ActiveSupport::Concern
  end
end

Dir[File.dirname(__FILE__) + "/bank_card/validations/*.rb"].sort.each do |path|
  filename = File.basename(path)
  require "bank_card/validations/#{filename}"
end

I18n.load_path << File.dirname(__FILE__) + '/bank_card/locale/en.yml'
