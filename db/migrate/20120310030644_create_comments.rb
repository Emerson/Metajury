class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :ancestry
      t.float :score
      t.integer :vote_tally

      t.timestamps
    end
  end
end
