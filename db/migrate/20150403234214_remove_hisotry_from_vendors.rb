class RemoveHisotryFromVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :hisotry
  end

  def down
    add_column :vendors, :hisotry, :string
  end
end
