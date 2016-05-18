module AuthHelpers
  def mock_mondo
    OmniAuth.config.mock_auth[:mondo] = OmniAuth::AuthHash.new(
      provider: :mondo,
      uid: account_id,
      info: {},
      credentials: {
        'token' => token
      }
    )
  end

  def mock_foursquare
    OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new(
      provider: 'foursquare',
      uid: 123,
      token: token,
      info: { 'email' => current_user.email },
      credentials: {
        'token' => token
      }
    )
  end
end
