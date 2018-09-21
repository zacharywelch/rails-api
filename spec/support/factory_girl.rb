# Start making use of Factory Bot. See factories in the spec/factories/ directory
# and how they're used in the specs (search for "create(:").

# Suggested docs
# --------------
# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
# https://github.com/thoughtbot/factory_bot/wiki/Example-factories.rb-file

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
