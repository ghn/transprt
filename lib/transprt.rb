require 'rubygems'
require 'rest_client'
require 'json'

class Transprt

  @domain = 'http://transport.opendata.ch'
  @version = 'v1'

  #
  # => find locations
  #
  def self.locations(parameters)

    allowed_parameters = ['query', 'x', 'y', 'type']

    query = self.create_query(parameters, allowed_parameters)

    locations = JSON.parse(RestClient.get self.create_url('locations') + query)

    locations['stations']
  end

  #
  # => find connections
  #
  def self.connections(parameters)
    allowed_parameters = ['from', 'to', 'via', 'date', 'time', 'isArrivalTime', 'transportations', 'limit', 'page',
      'direct', 'sleeper', 'couchette', 'bike']

    query = self.create_query(parameters, allowed_parameters)

    locations = JSON.parse(RestClient.get self.create_url('connections') + query)

    locations['connections']
  end

  #
  # => find station boards
  #
  def self.stationboard(parameters)
    allowed_parameters = ['station', 'id', 'limit', 'transportations', 'datetime']

    query = self.create_query(parameters, allowed_parameters)

    locations = JSON.parse(RestClient.get self.create_url('stationboard') + query)

    locations['stationboard']
  end

  private

  def self.create_url(base)
    [@domain, @version, base].join('/') + '?'
  end

  def self.create_query(parameters, allowed_parameters)
    query = parameters.map{|k,v|
        "#{k}=#{v}" if allowed_parameters.include? k.to_s
    }.join('&')
  end
end
