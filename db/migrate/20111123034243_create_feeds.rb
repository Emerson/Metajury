class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.text :data
      t.string :feed_type
      t.boolean :admin
      t.boolean :public_feed

      t.timestamps
    end
  end
end
