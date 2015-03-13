class Vendor < ActiveRecord::Base
  
  def self.create_with_omniauth(auth)
    create! do |vendor|
      vendor.provider = auth["provider"]
      vendor.uid = auth["uid"]
      vendor.name = auth["info"]["name"]
    end
  end
end
