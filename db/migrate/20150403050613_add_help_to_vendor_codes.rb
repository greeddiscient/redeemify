class AddHelpToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :help, :string
  end
end
