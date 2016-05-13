require 'rails_helper'
require 'support/setup_user'

RSpec.configure do |c|
  c.extend SetupUser
end

RSpec.describe User, type: :model do
  describe '#mondo' do
    setup_user
    setup_mondo

    it 'finds the correct join model' do
      expect(user.mondo).to eq mondo_join
    end
  end

  describe '#foursquare' do
    setup_user
    setup_foursquare

    it 'finds the correct join model' do
      expect(user.foursquare).to eq foursquare_join
    end
  end

  describe '#setup_categories' do
    setup_user

    it 'sets up initial categories' do
      category = Merchant::CATEGORIES.sample
      expect(user.send category).to be_truthy
    end
  end
end
