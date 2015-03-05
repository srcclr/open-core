class ChangeTopicsPositionDefaultValue < ActiveRecord::Migration
  def change
    change_column :topics, :position, :integer, null: false, default: -1
  end
end
