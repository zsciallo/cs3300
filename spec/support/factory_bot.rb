require 'rails_helper'
require_relative './controller_macros'
RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, :type => :controller
    config.include FactoryBot::Syntax::Methods
    config.extend ControllerMacros, :type => :controller
    config.include Devise::Test::IntegrationHelpers, type: :feature
end