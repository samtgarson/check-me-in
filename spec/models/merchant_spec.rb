require 'rails_helper'
require 'support/merchant_examples'
require 'support/read_fixture'

RSpec.configure do |c|
  c.extend ReadFixture
end

RSpec.describe Merchant, type: :model do
  describe '.create_from_transaction' do
    subject { Merchant.find_or_create_from_transaction data[:merchant] }

    context 'for a perfect transaction' do
      read_fixture 'spec/fixtures/transaction_perfect.json'
      it_behaves_like 'a valid merchant'

      it 'has a foursquare id' do
        expect(subject.foursquare_id?).to be_truthy
      end
    end

    context 'for a transaction with no foursquare id' do
      read_fixture 'spec/fixtures/transaction_no_foursquare.json'
      it_behaves_like 'a valid merchant'

      it 'has fetches a foursquare id' do
        expect(subject.foursquare_id?).to be_truthy
      end
    end
  end
end
