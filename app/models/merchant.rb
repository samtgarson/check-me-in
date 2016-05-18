class Merchant < ActiveRecord::Base
  has_many :transactions
  serialize :address
  after_create :fetch_foursquare_id, unless: :foursquare_id?
  validates :mondo_id, :address, :name, :category, presence: true

  CATEGORIES = %i(transport groceries eating_out cash bills entertainment shopping holidays general expenses).freeze

  class << self
    def find_or_create_from_transaction(data)
      find_or_create_by(mondo_id: data[:id]) do |m|
        m.attributes = transform_hash(data).deep_symbolize_keys
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
      attribute_names.map(&:to_sym) - [:id]
    end
  end

  private

  def fetch_foursquare_id
    foursquare_search[:venues].each do |venue|
      update_attributes(foursquare_id: venue[:id]) and break if venue.dig(:location, :postalCode) == address[:postcode]
    end
  end

  def foursquare_client
    FoursquareClient.new
  end

  def foursquare_search
    @foursquare_search ||= foursquare_client.search_venues(
      ll: "#{address[:latitude]}, #{address[:longitude]}",
      query: name
    ).deep_symbolize_keys
  end
end
