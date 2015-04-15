class RemoveInstructionFromVendorCodes < ActiveRecord::Migration
  def up
    remove_column :vendor_codes, :instruction
  end

  def down
    add_column :vendor_codes, :instruction, :string
  end
end
