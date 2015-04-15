class AddInstructionToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :instruction, :string
  end
end
