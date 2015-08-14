class AddChapterIdAndPositionToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :chapter_id, :integer
    add_column :topics, :position, :integer, null: false, default: 0

    add_index :topics, :chapter_id
    add_index :topics, :position
  end
end
