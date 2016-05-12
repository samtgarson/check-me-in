module SetupUser
  def setup_user
    let!(:user) { FactoryGirl.create :user }
  end

  def setup_mondo
    let!(:mondo) { FactoryGirl.create :authentication_provider, name: 'mondo' }
    before do
      UserAuthentication.create(
        user: user,
        authentication_provider: mondo,
        uid: 'acc_000096SKfC7FOW9wvuGfhJ')
    end
  end

  def setup_foursquare
    let!(:foursquare) { FactoryGirl.create :authentication_provider, name: 'mondo' }
    before do
      UserAuthentication.create(
        user: user,
        authentication_provider: foursquare,
        uid: 'acc_000096SKfC7FOW9wvuGfhJ')
      user
    end
  end
end
