class AddHistoryColumnToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :history, :string
  end
end
