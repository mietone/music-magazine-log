class MagazinesController < ApplicationController
  use Rack::Flash

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

  post '/magazines' do
    @magazine = current_user.magazines.build(params)
    if logged_in?
      if @magazine.save
        flash[:message] = "You have successfully added a magazine."
        redirect "/magazines/#{@magazine.id}"
      else
        flash[:message] = "Magazine name is required."
        redirect "/magazines/new"
      end
    else
      redirect "/login"
    end
  end

  get '/magazines/:id' do
    @mag = Magazine.find_by(id: params[:id])
    if logged_in?
      erb :'/magazines/show_mag'
    else
      redirect "/login"
    end
  end

  get '/magazines/:id/edit' do
    @mag = Magazine.find_by(id: params[:id])
    if logged_in?
      if current_user.magazines.include?(@mag)
        erb :'/magazines/edit_mag'
      else
        flash[:message] = "Sorry, you can not edit this magazine."
        redirect "/magazines"
      end
    else
      redirect "/login"
    end
  end

  patch '/magazines/:id' do
    @mag = Magazine.find_by(id: params[:id])
    if params[:name].empty?
      flash[:message] = "Magazine name is required."
      redirect "/magazines/#{@mag.id}/edit"
    else
      @mag.update(name: params[:name], year: params[:year], month: params[:month], cover: params[:cover], condition: params[:condition], notes: params[:notes])
      flash[:message] = "You have successfully edited the magazine."
      redirect "/magazines/#{@mag.id}"
    end
  end

  delete '/magazines/:id/delete' do
    @mag = Magazine.find_by(id: params[:id])
    if logged_in?
      @mag.destroy
      flash[:message] = "You have successfully deleted the magazine."
      redirect "/magazines"
    else
      redirect "/login"
    end
  end

end
