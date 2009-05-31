class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.find(:all)
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(params[:podcast])
    if @podcast.save
      redirect_to podcasts_path
    else
      render :action => 'new'
    end
  end

  def destroy
    Podcast.destroy(params[:id])
    redirect_to podcasts_path
  end

end
