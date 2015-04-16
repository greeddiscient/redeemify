class AddUserNameToProviderCodes < ActiveRecord::Migration
  def change
    add_column :provider_codes, :user_name, :string
  end
end
