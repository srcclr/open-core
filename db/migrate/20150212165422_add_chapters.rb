class AddChapters < ActiveRecord::Migration
  def change
    create_table :discourse_reports_chapters do |t|
      t.string :name, null: false, default: ''
      t.string :slug, null: false, default: ''

      t.belongs_to :discourse_reports_part

      t.integer :position, null: false, default: 0
    end

    add_index :discourse_reports_chapters, :discourse_reports_part_id
    add_index :discourse_reports_chapters, :position
  end
end
