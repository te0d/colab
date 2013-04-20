class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :group
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :discussions, :group_id
  end
end
