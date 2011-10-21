require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "siri_says"
  gem.homepage = "http://github.com/tysontate/siri_says/"
  gem.license = "MIT"
  gem.summary = %Q{Siri as a remote control.}
  gem.description = %Q{Siri as a remote control. Provides a basic DSL for handling commands from Siri via a ridiculous hack.}
  gem.email = "tyson@tysontate.com"
  gem.authors = ["Tyson Tate"]
end
Jeweler::RubygemsDotOrgTasks.new
