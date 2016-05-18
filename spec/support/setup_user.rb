require 'support/auth_helpers'

module SetupUser
  RSpec.configure do |c|
    c.include AuthHelpers
  end

  def setup_user
    let!(:current_user) { FactoryGirl.create :user }
    let(:account_id) { 'acc_000096SKfC7FOW9wvuGfhJ' }
    let(:token) { 'secure123' }
  end

  def setup_mondo
    let!(:mondo) { FactoryGirl.create :authentication_provider, name: 'mondo' }
    let!(:mondo_join) do
      UserAuthentication.create(
        user: current_user,
        authentication_provider: mondo,
        uid: account_id,
        token: token)
    end
  end

  def setup_foursquare
    let!(:foursquare) { FactoryGirl.create :authentication_provider, name: 'foursquare' }
    let!(:foursquare_join) do
      UserAuthentication.create(
        user: current_user,
        authentication_provider: foursquare,
        uid: account_id)
    end
  end

  def mock_auth
    before do
      OmniAuth.config.test_mode = true
      mock_mondo
      mock_foursquare
    end
  end
end
