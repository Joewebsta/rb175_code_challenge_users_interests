# frozen_string_literal: true

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

get '/' do
  redirect '/users'
end

get '/users' do
  @users = YAML.load_file('data/users.yaml')
  @user_names = @users.keys.map(&:capitalize)

  erb :users
end

get '/users/:name' do
  # params[:name]
  erb :user
end
