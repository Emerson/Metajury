class AddScoreToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :score, :float
    add_index :submissions, :score
  end
end
