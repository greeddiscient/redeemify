class AddUserNameToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :user_name, :string
  end
end
