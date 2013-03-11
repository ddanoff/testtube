class CreateBaselineTasks < ActiveRecord::Migration
  def change
    create_table :baseline_tasks do |t|
      t.references :ModelStoryType
      t.string :name
      t.string :description
      t.decimal :small_doit_loe_hours, :precision => 10, :scale => 2
      t.boolean :is_sensitive_to_size
      t.integer :review_team_size

      t.timestamps
    end
    add_index :baseline_tasks, :ModelStoryType_id
  end
end