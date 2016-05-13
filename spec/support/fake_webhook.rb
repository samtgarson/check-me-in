require 'faraday'

class FakeWebhook
  def initialize(fixture: nil, host: nil, path: nil, port: nil)
    @fixture = fixture
    @host = host
    @path = path
    @port = port

    load_fixture
    construct_connection
  end

  def send
    connection.post do |request|
      request.url path
      request.body = JSON.generate body
      request.headers['Content-Type'] = 'application/json'
    end
  end

  private

  attr_accessor(
    :body,
    :connection,
    :fixture,
    :path,
    :session
  )

  def construct_connection
    @connection = Faraday.new(url: "http://#{@host}:#{@port}")
  end

  def fixture_path
    "#{Rails.root}/spec/fixtures/#{fixture}"
  end

  def load_fixture
    @body = JSON.parse File.read(fixture_path)
  end
end
