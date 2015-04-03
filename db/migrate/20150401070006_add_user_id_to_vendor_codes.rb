class AddUserIdToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :user_id, :integer
  end
end
