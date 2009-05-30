class Podcast < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :asset_link
end
