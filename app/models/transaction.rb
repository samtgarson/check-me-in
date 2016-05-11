class Transaction < ActiveRecord::Base
  belongs_to :merchant
  serialize :data
  validates :data, :mondo_id, presence: true
  validates :merchant, presence: true, if: :valid_for_checkin?
  # after_create :trigger_checkin, if: :valid_for_checkin?

  class << self
    def create_from_api(data)
      create(transform_hash(data)).find_merchant(data[:merchant])
    end

    private

    def transform_hash(data)
      { data: data.slice(*allowed_attributes) }.tap do |d|
        d[:mondo_id] = data[:id]
      end
    end

    def allowed_attributes
      %i(is_load is_online currency amount category)
    end
  end

  def find_merchant(data)
    update_attributes(merchant: Merchant.find_or_create_from_transaction(data)) if valid_for_checkin? && data.any?
    self
  end

  def valid_for_checkin?
    !data[:is_load] && !data[:is_online]
  end

  def trigger_checkin
    merchant.check_in!
  end
end
