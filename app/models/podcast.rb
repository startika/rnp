class Podcast < ActiveRecord::Base

  has_many :comments

  validates_presence_of :title
  validates_presence_of :asset_link

  before_create :assign_number
  before_destroy :correct_numbers

  def assign_number
    self.number = 1 + Podcast.count
  end

  def correct_numbers
    Podcast.update_all "number = number - 1", [ "number > ?", number ]
  end

end
