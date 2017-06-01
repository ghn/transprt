# transprt

[![Gem Version](https://badge.fury.io/rb/transprt.svg)](https://badge.fury.io/rb/transprt)
[![Dependency Status](https://gemnasium.com/badges/github.com/ghn/transprt.svg)](https://gemnasium.com/github.com/ghn/transprt)
[![Build Status](https://travis-ci.org/ghn/transprt.svg?branch=master)](https://travis-ci.org/ghn/transprt)

Ruby client for the Swiss public transport API at http://transport.opendata.ch

## Installation

```bash
gem install transprt

#run example
ruby example.rb
```

## Usage

To talk to the API, get a client:

```ruby
require 'transprt'
client = Transprt::Client.new
```

See below how to use this client.

Hint: You may specify a mirror of the API other than http://transport.opendata.ch using the first argument of the constructor.


### Locations
http://transport.opendata.ch/#locations

```ruby
client.locations query: 'Geneva'
# => [{"id"=>"008501008", "name"=>"Genève", "score"=>"101", "coordinate"=>{"type"=>"WGS84", "x"=>6.142455, "y"=>46.210199}, "distance"=>nil}]
```

### Connections

http://transport.opendata.ch/#connections

```ruby
client.connections from: 'Lausanne', to: 'Geneva'
```

### Station board

http://transport.opendata.ch/#stationboard

```ruby
# Display station board
client.stationboard station: 'Lausanne'
```

## Development

Running the tests

```bash
rake test
```

## License

MIT License (MIT)
