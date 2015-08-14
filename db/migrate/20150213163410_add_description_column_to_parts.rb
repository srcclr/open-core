class AddDescriptionColumnToParts < ActiveRecord::Migration
  def change
    add_column :discourse_reports_parts, :description, :text, null: false, default: ''
  end
end
