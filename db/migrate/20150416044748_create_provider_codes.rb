class CreateProviderCodes < ActiveRecord::Migration
  def change
    create_table :provider_codes do |t|
      t.string :name
      t.string :code
      t.integer :user_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
