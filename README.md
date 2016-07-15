#transprt

[![Gem Version](https://badge.fury.io/rb/transprt.png)](http://badge.fury.io/rb/transprt)
[![Dependency Status](https://gemnasium.com/ghn/transprt.png)](https://gemnasium.com/ghn/transprt)

Ruby client for the Swiss public transport API at http://transport.opendata.ch

##Installation

```bash
gem install transprt

#run example
ruby example.rb
```

##Usage

###Locations
http://transport.opendata.ch/#locations

```ruby
require 'transprt'
Transprt.locations :query => 'Geneva'
# => [{"id"=>"008501008", "name"=>"Genève", "score"=>"101", "coordinate"=>{"type"=>"WGS84", "x"=>6.142455, "y"=>46.210199}, "distance"=>nil}]
```

###Connexions

http://transport.opendata.ch/#connections

```ruby
require 'transprt'
Transprt.connexions :from => 'Lausanne', :to => 'Geneva'
```

###Station board

http://transport.opendata.ch/#stationboard

```ruby
# Display station board
Transprt.stationboard :station => 'Lausanne'
```

##Licence

MIT License (MIT)
