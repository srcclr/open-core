class AddParentTopicToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :parent_topic_id, :integer
  end
end
