class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug, unique: true
      t.boolean :featured

      t.timestamps
    end
  end
end