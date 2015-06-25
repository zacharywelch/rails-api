class AddRankToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :rank, :integer
    add_index :albums, :rank
  end
end
