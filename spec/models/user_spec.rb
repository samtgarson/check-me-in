require 'rails_helper'
require 'support/setup_user'

RSpec.configure do |c|
  c.extend SetupUser
end

RSpec.describe User, type: :model do
  describe '#state' do
    setup_user

    context 'with only one account connected' do
      setup_mondo

      it 'doesnt transition' do
        expect(current_user.state).to eq 'created'
      end
    end

    context 'with both accounts connected' do
      setup_mondo
      setup_foursquare

      it 'transitions' do
        expect(current_user.state).to eq 'registered'
      end
    end
  end

  describe '#mondo' do
    setup_user
    setup_mondo

    it 'finds the correct join model' do
      expect(current_user.mondo).to eq mondo_join
    end
  end

  describe '#foursquare' do
    setup_user
    setup_foursquare

    it 'finds the correct join model' do
      expect(current_user.foursquare).to eq foursquare_join
    end
  end

  describe '#setup_categories' do
    setup_user

    it 'sets up initial categories' do
      category = Merchant::CATEGORIES.sample
      expect(current_user.send category).to be_truthy
    end
  end
end
