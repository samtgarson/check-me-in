require 'rails_helper'
require 'support/setup_user'

RSpec.configure do |c|
  c.extend SetupUser
end

RSpec.describe 'Receive a post from Mondo' do
  setup_user
  setup_mondo
  setup_foursquare

  context 'with perfect data', :js do
    let(:client) { instance_double("FoursquareClient") }
    let(:json) { File.read("#{Rails.root}/spec/fixtures/transaction_bibimbap.json") }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before do
      allow(FoursquareClient).to receive(:new).and_return(client)
    end

    it 'creates a checkin' do
      expect(client).to receive :checkin!
      post transactions_path, json, headers
    end
  end
end
