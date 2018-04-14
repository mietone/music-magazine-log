class MagazinesController < ApplicationController

  get '/magazines' do
    if logged_in?
      @mags = Magazine.all
      erb :'/magazines/mags'
    else
      redirect "/users/login"
    end
  end


  
end
