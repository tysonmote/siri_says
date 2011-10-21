require "rubygems"
require "gcal4ruby"
require "i18n"
require "active_support/core_ext"

module Kernel
  def siri_says( regex, &block )
    SiriSays::Plugins.add( regex, block )
  end
end

module SiriSays
  class Plugins
    class << self
      def add( regex, block )
        (@plugins ||= []) << {
          regex: regex,
          block: block
        }
      end
      
      def handle( message )
        (@plugins || []).each do |plugin|
          if message =~ plugin[:regex]
            plugin[:block].call( message )
          end
        end
      end
    end
  end
  
  class Engine
    class << self
      def run( username, password, interval=5 )
        @username = username
        @password = password
        @calendar_name = "sirisays"
        
        while true
          self.ranges.each do |range|
            GCal4Ruby::Event.find( self.service, @calendar_name, {
              "start-min" => range[:start],
              "start-max" => range[:end]
            }).each do |event|
              next if range[:all_day] != event.all_day
              SiriSays::Plugins.handle( event.title )
              event.delete
            end
          end
          sleep interval
        end
      end
      
      protected
      
      def ranges
        [
          # Sceduled events
          { start: scheduled_start, end: scheduled_end, all_day: false },
          # Immediate events are all-day events
          { start: immediate_start, end: immediate_end, all_day: true }
        ]
      end
      
      def scheduled_start
        xmltime( Time.now - 30.minutes )
      end
      
      def scheduled_end
        xmltime( Time.now )
      end
      
      def immediate_start
        xmltime( Date.tomorrow.beginning_of_day - 15.minutes )
      end
      
      def immediate_end
        xmltime( Date.tomorrow.beginning_of_day + 15.minutes )
      end
      
      def xmltime( time )
        time.xmlschema
      end
      
      def service
        return @service if @service
        begin
          @service = GCal4Ruby::Service.new
          @service.authenticate( @username, @password )
          @service
        rescue GData4Ruby::HTTPRequestFailed
          raise "User name or password was incorrect."
        end
      end
    end
  end
end
