# Echo everything that begins with "Campfire" (or "Camp fire") to a Campfire
# room.

require "rubygems"
require "siri-says"
require "broach"

CAMPFIRE_ROOM = "The Hub"

Broach.settings = {
  'account' => 'myaccount',
  'token'   => '********************',
  'use_ssl' => true
}

siri_says /camp\s?fire/ do |msg|
  Broach.speak( CAMPFIRE_ROOM, msg.sub( /^camp\?fire\s?/, "" ) )
end

SiriSays::Engine.run( "foo@gmail.com", "password" )
