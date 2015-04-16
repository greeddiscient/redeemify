class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :history
      t.string :provider
      t.string :email

      t.timestamps
    end
  end
end
