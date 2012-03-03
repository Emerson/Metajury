class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :url
      t.string :title
      t.text :description
      t.integer :vote_tally

      t.timestamps
    end
  end
end
