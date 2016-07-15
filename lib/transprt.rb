require 'rubygems'
require 'rest_client'
require 'json'

module Transprt
  class Client
    DEFAULT_DOMAIN = 'http://transport.opendata.ch'
    VERSION = 'v1'

    def initialize(domain=DEFAULT_DOMAIN, version=VERSION)
      @domain = domain
      @version = version
    end

    #
    # => find locations
    #
    def locations(parameters)
      allowed_parameters = ['query', 'x', 'y', 'type']

      query = create_query(parameters, allowed_parameters)
      locations = perform('locations', query)

      locations['stations']
    end

    #
    # => find connections
    #
    def connections(parameters)
      allowed_parameters = ['from', 'to', 'via', 'date', 'time', 'isArrivalTime', 'transportations', 'limit', 'page',
                            'direct', 'sleeper', 'couchette', 'bike']

      query = create_query(parameters, allowed_parameters)
      locations = perform('connections', query)

      locations['connections']
    end

    #
    # => find station boards
    #
    def stationboard(parameters)
      allowed_parameters = ['station', 'id', 'limit', 'transportations', 'datetime']

      query = create_query(parameters, allowed_parameters)
      locations = perform('stationboard', query)

      locations['stationboard']
    end

    private
    attr_reader :domain, :version

    def perform(endpoint, query)
      url = "#{create_url(endpoint)}#{query}"
      response = RestClient.get(url)

      # Uncomment the line below to dump the response in order to generate
      # a file to use as response stub in tests.
      # File.write('/tmp/response.json', response)

      JSON.parse(response)
    end

    def create_url(endpoint)
      [domain, version, endpoint].join('/') + '?'
    end

    def create_query(parameters, allowed_parameters)
      parameters.map{|k,v|
        "#{k}=#{v}" if allowed_parameters.include? k.to_s
      }.join('&')
    end
  end
end
