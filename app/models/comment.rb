class Comment < ActiveRecord::Base

  belongs_to :podcast

  validates_presence_of :podcast_id
  validates_presence_of :author_name
  validates_presence_of :body

end
