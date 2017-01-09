#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './lib/nouns.rb'
require './lib/nouns/things.rb'
require './lib/nouns/things/datable.rb'
require './lib/nouns/things/contact.rb'
require './lib/nouns/things/area.rb'
require './lib/nouns/things/project.rb'
require './lib/nouns/things/todo.rb'

require './lib/nouns/syncer/people.rb'
require './lib/nouns/syncer/meeting.rb'

#binding.pry

Nouns::Syncer::People.sync!
Nouns::Syncer::Meeting.sync!