class AddNumberToPodcast < ActiveRecord::Migration
  def self.up
    add_column :podcasts, :number, :integer
  end

  def self.down
    remove_column :podcasts, :number
  end
end
