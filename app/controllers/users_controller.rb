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
      redirect "/users/signup"
    end
  end


end
