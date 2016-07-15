require File.join(File.dirname(__FILE__), 'lib/transprt')

client = Transprt::Client.new
puts client.locations query: 'genf'
puts client.connections from: 'Lausanne', to: 'Geneve'
puts client.locations station: 'Aarau'
