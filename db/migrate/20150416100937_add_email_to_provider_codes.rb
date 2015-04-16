class AddEmailToProviderCodes < ActiveRecord::Migration
  def change
    add_column :provider_codes, :email, :string
  end
end
