require 'rails_helper'
require 'support/setup_user'
require 'support/fake_webhook'

RSpec.configure do |c|
  c.extend SetupUser
end

RSpec.feature 'User creates an account' do
  setup_user
  mock_auth

  scenario 'a mondo webhook is registered' do
    log_in
    expect(a_request(:post, %r{api.getmondo.co.uk/webhooks})).to have_been_made.once
  end

  context 'with perfect data', :js do
    before do
      log_in
    end

    scenario 'and sees their transaction' do
      trigger_webhook 'transaction_bibimbap.json', transactions_path
      visit root_path
      expect(page).to have_selector 'td', text: 'BiBimBap'
    end
  end

  def log_in
    visit root_path

    click_link 'Log in with Mondo'
    expect(page).to have_selector 'p', text: /Connected Mondo/i

    click_link 'Log in with Foursquare'
    expect(page).to have_selector 'h2', text: 'Check Me In is all set!'
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
