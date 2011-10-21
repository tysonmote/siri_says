# Just echo everything to the command line.

require "rubygems"
require "siri-says"

siri_says /./ do |msg|
  puts msg
end

SiriSays::Engine.run( "foo@gmail.com", "password" )
