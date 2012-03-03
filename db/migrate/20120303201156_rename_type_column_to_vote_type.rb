class RenameTypeColumnToVoteType < ActiveRecord::Migration
  def up
  	rename_column :votes, :type, :vote_type
  end

  def down
  	rename_column :votes, :vote_type, :type
  end
end
