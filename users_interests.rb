# frozen_string_literal: true

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

before do
  @users = YAML.load_file('data/users.yaml')
end

get '/' do
  redirect '/users'
end

get '/users' do
  @user_names = @users.keys
  erb :users
end

get '/users/:name' do
  @name = params[:name]
  user_info = @users[@name.to_sym]
  @email = user_info[:email]
  @interests = user_info[:interests].join(', ')
  erb :user
end
