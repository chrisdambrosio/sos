class CreateContactMethods < ActiveRecord::Migration
  def change
    create_table :contact_methods do |t|
      t.string :label
      t.string :address
      t.integer :type_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
