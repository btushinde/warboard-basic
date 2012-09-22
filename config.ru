require 'sinatra'
require 'pusher'
require 'json'
require 'haml'
require './warboard'

set :run, false
set :raise_errors, true

run Sinatra::Application