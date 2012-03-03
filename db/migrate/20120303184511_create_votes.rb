class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :group_id
      t.string :type

      t.timestamps
    end
  end
end
