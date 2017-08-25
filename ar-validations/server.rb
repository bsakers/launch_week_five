require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'
require_relative './app/models/comment'
require_relative './app/models/recipe'

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  @recipes = Recipe.all
  erb :index
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  @comments = @recipe.comments
  erb :show
end
