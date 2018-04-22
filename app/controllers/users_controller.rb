class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      flash[:message] = "You're already logged in."
      redirect "/magazines"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id

      flash[:message] = "Signup was successful and you're logged in."
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "All fields are required to create an account."
      redirect "/signup"
    end
  end

  get '/login' do
    binding.pry
    if logged_in?
      # flash[:message] = "You're logged in."
      redirect "/magazines"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "You have successfully logged in."
      redirect "/magazines"
    else
      flash[:message] = "Invalid login. Please try again or create an account."
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "You have successfully logged out."
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
