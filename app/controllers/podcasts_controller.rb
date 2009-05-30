class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.find(:all)
  end

end
