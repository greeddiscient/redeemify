class Vendor < ActiveRecord::Base 
	require 'csv'
	has_many :vendorCodes

	def self.create_with_omniauth(auth)
	    create! do |user|
	      user.provider = auth["provider"]
	      user.uid = auth["uid"]
	      user.name = auth["info"]["name"]
	      user.email = auth["info"]["email"]
	      user.code = ""
    	end
  	end

  	def self.import(file, current_vendor, info)
    	CSV.foreach(file.path, headers: true) do |row|

	      	code = row.to_hash # exclude the price field
	      	# debugger
	      	current_vendor.vendorCodes.create!(:code => code["code"], :vendor => current_vendor, :instruction => info["instruction"], :help => info["help"], :expiration => info["expiration"])

	      	#if product.count == 1
		        #product.first.update_attributes(product_hash)
		    #else
		        #Product.create!(product_hash)
		    #end # end if !product.nil?
		end # end CSV.foreach
  	end # end self.import(file)

end