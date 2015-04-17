class Vendor < ActiveRecord::Base 
	# require 'csv'
	has_many :vendorCodes
	attr_accessible :history, :provider, :email, :name , :description, :instruction, :website, :comment , :helpLink, :expiration, :cashValue

  	def self.import(file, current_vendor, info)
  		numberOfCodes = 0
  		date = ""
    	# CSV.foreach(file.path, headers: true) do |row|
    	f = File.open(file.path, "r")
		f.each_line do |row|
			row = row.gsub(/\s+/, "")  # 12 3 4 --> 1234, 
			if row !=  ""   # don't get any blank code
		      	a = current_vendor.vendorCodes.create!(:code => row, :name => current_vendor.name , :vendor => current_vendor)
		      	numberOfCodes = numberOfCodes + 1
		      	date = a.created_at
		     end
		end # end CSV.foreach
		f.close
		history = current_vendor.history
		
	    date = date.to_formatted_s(:long_ordinal)
	    if history == nil
	    	history = "#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    else
	    	history = "#{history}#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    end
	    current_vendor.update_attribute(:history, history)


  	end # end self.import(file)


  	def self.update_profile_vendor(current_vendor,info)
  		current_vendor.update_attributes(:cashValue => info["cashValue"], :expiration => info["expiration"], :helpLink => info["helpLink"],:instruction => info["instruction"])
  	end # end self.profile()

  	def self.remove_unclaimed_codes(current_vendor)
  		unclaimedCodes=current_vendor.vendorCodes.where(:user_id => nil)
  		unclaimedCodes.each do |code|
  			code.destroy
  		end
  	end

end