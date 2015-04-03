class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
  attr_accessible :code, :vendor , :user_id

end
