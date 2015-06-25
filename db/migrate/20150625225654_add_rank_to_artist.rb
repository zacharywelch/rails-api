class AddRankToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :rank, :integer
    add_index :artists, :rank
  end
end
