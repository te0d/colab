class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user
      t.references :group
      t.integer :level

      t.timestamps
    end
    add_index :permissions, :user_id
    add_index :permissions, :group_id
  end
end
