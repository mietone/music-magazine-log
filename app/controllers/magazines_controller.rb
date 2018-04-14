class MagazinesController < ApplicationController

  get '/magazines' do
    if logged_in?
      @mags = Magazine.all
      erb :'/magazines/mags'
    else
      redirect "/users/login"
    end
  end

  get '/magazines/new' do
    if logged_in?
      erb :'/magazines/create_mag'
    else
      redirect "/login"
    end
  end



end
