class AddHelpLinkToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :helpLink, :string
  end
end
