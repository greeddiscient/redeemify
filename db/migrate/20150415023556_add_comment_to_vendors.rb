class AddCommentToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :comment, :string
  end
end
