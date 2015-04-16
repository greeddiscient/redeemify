class AddEmailToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :email, :string
  end
end
