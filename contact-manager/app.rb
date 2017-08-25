require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require "pry"

require_relative 'models/contact'
also_reload 'models/contact'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  @contacts = Contact.all
  erb :index
end

get '/contacts/:id' do
  @specific_contact = Contact.find(params[:id])
  erb :show
end

post '/contacts' do
  @search_item = params["Name"]
  redirect '/search'
end

get '/search' do
  @search_contacts = Contact.where(name: @search_item)
  binding.pry
  erb :search
end
