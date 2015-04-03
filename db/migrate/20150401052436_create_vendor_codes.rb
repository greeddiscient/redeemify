class CreateVendorCodes < ActiveRecord::Migration
  def change
    create_table :vendor_codes do |t|
      t.string :code
      t.string :vendor

      t.timestamps
    end
  end
end
