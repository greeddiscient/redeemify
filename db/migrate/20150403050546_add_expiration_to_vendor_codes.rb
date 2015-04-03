class AddExpirationToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :expiration, :string
  end
end
