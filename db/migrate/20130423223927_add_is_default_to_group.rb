class AddIsDefaultToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :is_default, :boolean, :default => false
  end
end
