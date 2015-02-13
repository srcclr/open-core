class AddDescriptionColumnToParts < ActiveRecord::Migration
  def change
    add_column :discourse_reports_parts, :description, :string, null: false, default: ''
  end
end
