ActiveAdmin.register VendorCode do
index do   
    # column :user_id  
    column :user_name
    column :email                                                
    column :code
    column :name
    column :created_at                                     
  end
  filter :name
  filter :user_name
  filter :email
  filter :user_id
  filter :code
end