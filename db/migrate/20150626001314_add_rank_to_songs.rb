class AddRankToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :rank, :integer
    add_index :songs, :rank
  end
end
