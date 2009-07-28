class PodcastsController < ApplicationController

  before_filter :restrict_access, :only => [ :new, :create, :edit, :update, :destroy ]

  def index
    @podcasts = Podcast.find(:all)
  end

  def show
    @podcast = Podcast.find(params[:id])
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

  def edit
    @podcast = Podcast.find(params[:id])
  end

  def update
    @podcast = Podcast.find(params[:id])
    if @podcast.update_attributes(params[:podcast])
      redirect_to podcasts_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    Podcast.destroy(params[:id])
    redirect_to podcasts_path
  end

end
