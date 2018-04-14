class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/magazines"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] == user.id
      redirect "/users/#{user.slug}"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/magazines"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/magazines"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      # message "You have successfully logged out."
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
