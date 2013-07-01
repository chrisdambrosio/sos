class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.references :alert, index: true
      t.string :action
      t.integer :subjectable_id
      t.string  :subjectable_type
      t.integer :objectable_id
      t.string  :objectable_type

      t.timestamps
    end
  end
end
