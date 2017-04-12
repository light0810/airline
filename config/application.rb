require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(*Rails.groups)

module Airline
  class Application < Rails::Application
    config.time_zone = "Hanoi"
    config.i18n.default_locale = :vi
    config.active_record.raise_in_transactional_callbacks = true
  end
end
