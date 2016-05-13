require 'rails_helper'
require 'support/setup_user'
require 'support/fake_webhook'

RSpec.configure do |c|
  c.extend SetupUser
end

RSpec.feature 'Receive a post from Mondo' do
  setup_user
  setup_mondo
  setup_foursquare

  context 'with perfect data', :js do
    background do
      trigger_webhook 'transaction_bibimbap.json', transactions_path
    end

    scenario 'it creates a checkin' do
      expect(user.reload.transactions.count).to eq 1
    end
  end

  def trigger_webhook(fixture, path)
    FakeWebhook.new(
      fixture: fixture,
      host: Capybara.current_session.server.host,
      path: path,
      port: Capybara.current_session.server.port
    ).send
  end
end
