class AddCashValueToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :cashValue, :string
  end
end
