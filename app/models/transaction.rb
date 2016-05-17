class Transaction < ActiveRecord::Base
  class << self
    def create_from_api(data)
      create(transform_hash(data)).find_merchant(data[:merchant])
    end

    private

    def transform_hash(data)
      { data: data.slice(*allowed_attributes) }.tap do |d|
        d[:mondo_id] = data[:id]
        d[:account_id] = data[:account_id]
      end
    end

    def allowed_attributes
      %i(is_load is_online currency amount)
    end
  end

  belongs_to :merchant
  belongs_to :user
  serialize :data
  validates :data, :mondo_id, :user, presence: true

  scope :complete, -> { with_state(:ready, :failed, :checked_in) }

  state_machine initial: :created do
    event :get_ready do
      transition created: :ready, if: 'merchant.present?'
    end

    event :checkin do
      transition ready: :processing, if: :good_to_go?
    end

    event :succeed_checkin do
      transition processing: :checked_in
    end

    event :fail_checkin do
      transition processing: :failed
    end

    state :ready do
      validates :merchant, presence: true
    end

    after_transition ready: :processing do |transaction, _transition|
      FoursquareClient.new(transaction.user).checkin!(transaction)
    end
  end

  def account_id=(id)
    self.user = User.find_by_mondo_id(id)
  end

  def find_merchant(data)
    return self unless valid_for_checkin? && data.any?
    update_attributes(
      merchant: Merchant.find_or_create_from_transaction(data),
      state_event: 'get_ready')
    self
  end

  def good_to_go?
    valid? && valid_for_checkin? && user_allows? && merchant.foursquare_id?
  end

  private

  def valid_for_checkin?
    !data[:is_load] && !data[:is_online]
  end

  def user_allows?
    user.allows_checkins && user.send(merchant.category)
  end
end
