class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "extra secret"
  end

  get '/' do
    "Hello World!"
    # erb :'index'
  end

end
