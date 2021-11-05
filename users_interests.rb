# frozen_string_literal: true

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

get '/' do
  'HELLO WORLD'
end
