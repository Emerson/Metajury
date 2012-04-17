class AddSubmissionsTagsTable < ActiveRecord::Migration
  def change
    create_table :submissions_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :submission_id
    end
  end
end