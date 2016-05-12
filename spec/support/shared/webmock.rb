RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /.*api.foursquare.com.*Yoobi.*/)
      .to_return(status: 200, headers: {}, body: File.read('spec/fixtures/foursquare_yoobi.json'))
  end
end
