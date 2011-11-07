class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :last_login_ip
      t.integer :login_count
      t.timestamp :last_login_time
      t.string :token
      t.boolean :confirmed

      t.timestamps
    end
  end
end
