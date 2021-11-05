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
  @other_users = remove_current_user
  erb :user
end

helpers do
  def remove_current_user
    @users.keys.map(&:to_s).reject { |other_name| other_name == @name }
  end
end
