require File.join(File.dirname(__FILE__), 'lib/transprt')

puts Transprt.locations :query => 'genf'
puts Transprt.connections :from => 'Lausanne', :to => 'Geneve'
puts Transprt.locations :station => 'Aarau'
