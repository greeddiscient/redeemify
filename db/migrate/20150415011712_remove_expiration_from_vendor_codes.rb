class RemoveExpirationFromVendorCodes < ActiveRecord::Migration
  def up
    remove_column :vendor_codes, :expiration
  end

  def down
    add_column :vendor_codes, :expiration, :string
  end
end
