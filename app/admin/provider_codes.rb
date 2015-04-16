ActiveAdmin.register ProviderCode do
index do   
    column :user_id                                                  
    column :code
    column :name
    column :created_at                                     
  end
  filter :name
  filter :user_id
  filter :code
end