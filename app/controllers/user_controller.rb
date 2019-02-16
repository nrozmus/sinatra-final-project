class UserController < ApplicationController
require 'sinatra/flash'
register Sinatra::Flash

get '/signup' do
    !logged_in? ? (erb :'/users/signup') : (redirect "/")
end

get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/account'
end

post '/signup' do
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
        (session[:user_id] = user.id)
        (redirect "/projects")
    else
        flash[:error] = "Something went wrong. Please try again!"
        redirect "/signup"
    end
end

get '/login' do
    user = User.find_by(:username => params[:username])
    !logged_in? ? (erb :'/users/login') : (redirect "/projects")
end

post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/projects"
    else
        flash[:error] = "Incorrect username or password. Please try again!"
        redirect "/login"
    end
end

get "/logout" do
    if logged_in?
        session.destroy
        redirect '/login'
    else
        flash[:error] = "Something went wrong. Please try again!"
        redirect "/"
    end
end

def self.search(search)
where( "name like ?","%#{search}%")
end
end
