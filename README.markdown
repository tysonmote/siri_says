# Siri Says #

Siri Says gets that Siri biz-nass all up in your Ruby. Inspired by [Remember the Milk][rtm].

    require "rubygems"
    require "siri_says"
    
    siri_says /deploy/ do |message|
      puts "> Deploying..."
    end
    
    SiriSays::Engine.run( google_username, google_password )

Tell Siri: "Schedule a deploy right now."

(seconds later)

    > Deploying...

Boom. [Headshot][headshot].

## Initial setup ##

This is a bit of a pain. Suck it up, cowboy.

### Google Calendar ###

Add a new "sirisays" calendar.

### iPhone ###

Add the calendar:

1. Settings
2. "Mail, Contacts, Calendars"
3. "Add Account..."
4. "Other"
5. "Add CalDAV Account"
    * Server: google.com
    * Username: username@gmail.com
    * Password: ___________
    * Description: "sirisays"
6. "Next"

Make it the default so that Siri will add events to it:

1. Settings
2. "Mail, Contacts, Calendars"
3. "Default Calendar" --> sirisays
4. Go to [https://www.google.com/calendar/iphoneselect][iphoneselect] and choose "sirisays" (not sure if this is necessary, actually...)

## Usage ##

Write Siri Says plugins (as many as you want) with `siri_says`:

    siri_says /deploy/i do |message|
      puts "> Deploying..."
    end
    
    siri_says /^say/i do |message|
      puts "> Siri says: #{message.gsub(/^say/i, '')}"
    end

Then start SiriSays with your Google Calendar user name and password:

    SiriSays::Engine.run( google_username, google_password )

When a message is received (i.e. when a calendar event is added), it will be passed to every block whose associated RegEx is a match for the message. The message is the calendar event's title.

## Sending events ##

Google Calendar doesn't recognize Siri's "reminders". To communicate with Siri Says, you'll need to create actual calendar events. Siri Says recognizes "immediate" events and scheduled events:

### Immediate events ###

To create an immediate event, you can either create an event "now" or "all-day tomorrow":

* "Schedule a deploy right now"
* "Schedule an event right now: deploy"
* "Schedule an appointment tomorrow, all-day: deploy"
* "New appointment now: deploy"
* Etc.

### Scheduled events ###

Create events that fire later just like you would any other scheduled event:

* "New appointment for tomorrow at 4am: deploy"
* "Schedule a deploy tomorrow at 4am"
* "Schedule an event tomorrow at 4am: deploy"
* "Schedule an appointment tomorrow, at 4am: deploy"
* Etc.

## To do ##

* Remove needless dependency on ActiveSupport. I'm lazy.
* Remove dependency on Google Calendar -- allow any CalDAV server.
* Add Twilio SMS support. (bo-ring)

## Note ##

"Siri Says" isn't affiliated or endorsed by Apple in any way, shape, or form. It's just a dumb hack.

[rtm]: http://www.rememberthemilk.com/services/siri/
[iphoneselect]: https://www.google.com/calendar/iphoneselect
[headshot]: http://www.youtube.com/watch?v=olm7xC-gBMY
