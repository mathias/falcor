require 'falcor'

require 'coveralls'
Coveralls.wear!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
