require 'sinatra'
require_relative 'config/application'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user= User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."
  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(:name)
  erb :'meetups/index'
end

get '/meetups/:id' do
  @id =params[:id]
  @meetupInfo = Meetup.find(params[:id])
  @attendees = @meetupInfo.users
  erb :'meetups/show'
end

post '/meetups/:id' do

  attendees = Meetup.find(params[:id]).users
  if current_user
    attendees.each do |attendee|
      if attendee.id == current_user.id
        flash[:notice]= "You've already signed up for this meeting!"
        redirect "/meetups/#{params[:id]}"
        return
      end
    end
    Rsvp.create(meetup: Meetup.find(params[:id]), user: current_user)
    flash[:notice]= "You have joined the meeting"
    redirect "/meetups/#{params[:id]}"
  else
    flash[:notice]= "You need to be signed in"
    redirect "/meetups/#{params[:id]}"
  end
end

get '/new' do
  if session[:user_id]
    erb :'meetups/new_meetup'
  else
    erb :'meetups/error'
  end
end

post '/new' do
  @name = params["Name"]
  @description=params["description"]
  @location=params["location"]
  userName= current_user.username
  newMeetup = Meetup.create(name: @name, description: @description, location: @location, creator: userName);
  if newMeetup.valid?
    flash[:notice]= "Meetup was successfully created"
    redirect "/meetups/#{newMeetup.id}"
  else
    flash[:notice]= newMeetup.errors.full_messages
    redirect "/new"
  end
end
