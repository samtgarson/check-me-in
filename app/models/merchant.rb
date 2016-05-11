class Merchant < ActiveRecord::Base
  has_many :transactions
  serialize :address
  after_create :fetch_foursquare_id, unless: :foursquare_id?

  validates :mondo_id, :address, :name, presence: true

  class << self
    def find_or_create_from_transaction(data)
      find_or_create_by(mondo_id: data[:id]) do |m|
        m.attributes = transform_hash data
      end
    end

    private

    def transform_hash(data)
      data.slice(*allowed_attributes).tap do |d|
        d[:foursquare_id] = data.dig(:metadata, :foursquare_id)
        d[:mondo_id] = data[:id]
      end
    end

    def allowed_attributes
      attribute_names.map(&:to_sym)
    end
  end

  def check_in!
  end

  private

  def fetch_foursquare_id
  end
end
