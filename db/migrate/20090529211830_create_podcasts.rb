class CreatePodcasts < ActiveRecord::Migration
  def self.up
    create_table :podcasts do |t|
      t.string :title
      t.text :summary
      t.string :asset_link

      t.timestamps
    end
  end

  def self.down
    drop_table :podcasts
  end
end
