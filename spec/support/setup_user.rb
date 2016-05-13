module SetupUser
  def setup_user
    let!(:user) { FactoryGirl.create :user }
    let(:account_id) { 'acc_000096SKfC7FOW9wvuGfhJ' }
  end

  def setup_mondo
    let!(:mondo) { FactoryGirl.create :authentication_provider, name: 'mondo' }
    let!(:mondo_join) do
      UserAuthentication.create(
        user: user,
        authentication_provider: mondo,
        uid: account_id)
    end
  end

  def setup_foursquare
    let!(:foursquare) { FactoryGirl.create :authentication_provider, name: 'foursquare' }
    let!(:foursquare_join) do
      UserAuthentication.create(
        user: user,
        authentication_provider: foursquare,
        uid: account_id)
    end
  end
end
