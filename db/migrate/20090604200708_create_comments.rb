class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :podcast_id, :null => false

      t.string :author_name, :null => false
      t.string :author_url

      t.text :body, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
