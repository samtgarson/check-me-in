class FoursquareClient
  attr_reader :client
  delegate :search_venues, to: :client

  API_VERSION = '20160505'.freeze

  def initialize(user = nil)
    @user = user
    @client = Foursquare2::Client.new(client_options.merge api_version: API_VERSION)
  end

  def checkin!(transaction)
    client.add_checkin(
      venueId: transaction.merchant.foursquare_id,
      shout: transaction.merchant.emoji)
    transaction.succeed_checkin
  rescue Foursquare2::APIError => e
    transaction.fail_checkin
    raise e
  end

  private

  def client_options
    @options ||= if @user.present?
                   { oauth_token: @user.foursquare.token }
                 else
                   { client_id: ENV['FOURSQUARE_APP_ID'], client_secret: ENV['FOURSQUARE_APP_SECRET'] }
                 end
  end
end
