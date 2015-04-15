class AddExpirationToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :expiration, :string
  end
end
