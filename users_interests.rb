# frozen_string_literal: true

require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

before do
  @users = YAML.load_file('data/users.yaml')
  @user_count = @users.keys.size
  @interest_count = count_interests
end

get '/' do
  redirect '/users'
end

get '/users' do
  @user_names = @users.keys
  @title = 'Users'
  erb :users
end

get '/users/:name' do
  @name = params[:name]
  user_info = @users[@name.to_sym]
  @email = user_info[:email]
  @interests = user_info[:interests].join(', ')
  @other_users = remove_current_user
  @title = @name.capitalize
  erb :user
end

helpers do
  def remove_current_user
    @users.keys.map(&:to_s).reject { |other_name| other_name == @name }
  end

  def count_interests
    @users.values.map { |user_info| user_info[:interests] }.flatten.count
  end
end
