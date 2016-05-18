RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /.*api.foursquare.com.*Yoobi.*/)
      .to_return(status: 200, headers: {}, body: File.read('spec/fixtures/foursquare_yoobi.json'))

    stub_request(:post, %r{.*api.getmondo.co.uk/webhooks.*})
      .to_return(status: 200, headers: {}, body: File.read('spec/fixtures/mondo_webhook_response.json'))

    stub_request(:get, %r{.*api.getmondo.co.uk/webhooks.*})
      .to_return(status: 200, headers: {}, body: File.read('spec/fixtures/mondo_webhooks_response.json'))
  end
end
