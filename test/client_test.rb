require 'test_helper'
require 'pp'

class ClientTest < Minitest::Test
  def setup
    WebMock.reset!

    @client = Transprt::Client.new
  end

  def test_locations
    stub_response('client_test_test_locations.json')

    locations = @client.locations query: 'genf'

    assert locations.length == 1

    first_location = locations.first

    assert first_location['id'] == '008501008'
    assert first_location['name'] == 'Genève'
  end

  def test_connections
    stub_response('client_test_test_connections.json')

    connections = @client.connections from: 'Lausanne', to: 'Geneve'

    first_connection = connections.first

    assert first_connection['from']['station']['name'] == 'Lausanne'
    assert first_connection['to']['station']['name'] == 'Genève'
  end

  def test_stationboard
    skip 'feel free to add a test for Client#stationboard'
  end

  def test_escaping
    stub_request(:get, /.*/).to_return(
      status: 200,
      body: { connections: nil }.to_json)

    # The following line fails with an URI::InvalidURIError
    # should the umlaut in 'Zurich' not get escaped.
    connections = @client.connections from: 'Lausanne', to: 'Zürich'
  end

  def stub_response(name, url = /.*/, method = :get)
    # Uncomment lines below should you feel the urge to test against the live
    # API as the stubbing isn't very thorough as of now. (e.g. URLs requested
    # aren't checked)
    # WebMock.allow_net_connect!
    # return

    dirname = File.dirname(__FILE__)

    content = File.read("#{dirname}/responses/#{name}")

    stub_request(method, url).to_return(status: 200, body: content)
  end
end
