require 'rails_helper'
require 'support/transaction_examples'
require 'support/read_fixture'

RSpec.configure do |c|
  c.extend ReadFixture
end

RSpec.describe Transaction, type: :model do
  describe '.create_from_transaction' do
    before do
      allow(Merchant).to receive(:find_or_create_from_transaction)
        .and_return(FactoryGirl.create :merchant, :with_foursquare)

      allow(User).to receive(:find_by_mondo_id)
        .and_return(FactoryGirl.create :user)
    end

    subject { Transaction.create_from_api data }

    context 'for a perfect transaction' do
      read_fixture 'spec/fixtures/transaction_bibimbap.json'
      it_behaves_like 'a valid transaction'

      it 'has a merchant' do
        expect(subject.merchant).to be_a Merchant
      end
    end

    context 'for an irelevant transaction' do
      read_fixture 'spec/fixtures/transaction_load.json'
      it_behaves_like 'a valid transaction'

      it 'has no merchant' do
        expect(subject.merchant).to be_nil
      end
    end
  end
end
