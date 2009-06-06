class SessionsController < ApplicationController

  layout 'sessions'

  def new
  end

  def create
    access_token = params[:access_token]
    if access_token == APP_CONFIG[:access_token]
      session[:access_token] = access_token
      redirect_to podcasts_path
    else
      flash.now[:error] = 'Wrong access token'
      render 'new'
    end
  end

end
