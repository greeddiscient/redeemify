class RemoveHelpFromVendorCodes < ActiveRecord::Migration
  def up
    remove_column :vendor_codes, :help
  end

  def down
    add_column :vendor_codes, :help, :string
  end
end
