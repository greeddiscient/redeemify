class AddInstructionToVendorCodes < ActiveRecord::Migration
  def change
    add_column :vendor_codes, :instruction, :string
  end
end
