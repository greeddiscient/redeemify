class RemoveHistoryFromVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :history
  end

  def down
    add_column :vendors, :history, :thearray
  end
end
