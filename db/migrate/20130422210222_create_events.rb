class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :group
      t.string :name
      t.text :description
      t.datetime :when
      t.string :where

      t.timestamps
    end
    add_index :events, :group_id
  end
end
