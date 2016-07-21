require 'rubygems'
require 'rest_client'
require 'json'

require_relative 'rate_limiting'

module Transprt
  class Client
    DEFAULT_DOMAIN = 'http://transport.opendata.ch'.freeze
    VERSION = 'v1'.freeze

    def initialize(domain = DEFAULT_DOMAIN, version = VERSION)
      @domain = domain
      @version = version
    end

    #
    # => find locations
    #
    def locations(parameters)
      allowed_parameters = %w(query x y type)

      query = create_query(parameters, allowed_parameters)
      locations = perform('locations', query)

      locations['stations']
    end

    #
    # => find connections
    #
    def connections(parameters)
      allowed_parameters = %w(from to via date time isArrivalTime
                              transportations limit page direct sleeper
                              couchette bike)

      query = create_query(parameters, allowed_parameters)
      locations = perform('connections', query)

      locations['connections']
    end

    #
    # => find station boards
    #
    def stationboard(parameters)
      allowed_parameters = %w(station id limit transportations datetime)

      query = create_query(parameters, allowed_parameters)
      locations = perform('stationboard', query)

      locations['stationboard']
    end

    private

    attr_reader :domain, :version

    def perform(endpoint, query)
      url = "#{create_url(endpoint)}#{query}"

      response = limiter.get(url)

      # Uncomment the line below to dump the response in order to generate
      # a file to use as response stub in tests.
      # File.write('/tmp/response.json', response)

      JSON.parse(response)
    end

    def create_url(endpoint)
      [domain, version, endpoint].join('/') + '?'
    end

    def create_query(parameters, allowed_parameters)
      parameters.map do |k, v|
        next unless allowed_parameters.include?(k.to_s)

        "#{k}=#{CGI.escape(v)}"
      end.join('&')
    end

    def limiter
      @limiter ||= RateLimiting.new
    end
  end
end
