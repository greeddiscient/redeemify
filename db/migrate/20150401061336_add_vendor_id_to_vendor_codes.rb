class AddVendorIdToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :vendor_id, :integer
  end
end
