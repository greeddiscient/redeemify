class Vendor < ActiveRecord::Base 
	require 'csv'
	has_many :vendorCodes
	attr_accessible :history, :provider, :email, :name , :description, :instruction, :website, :comment , :helpLink, :expiration, :cashValue

  	def self.import(file, current_vendor, info)
  		numberOfCodes = 0
  		date = ""
    	CSV.foreach(file.path, headers: true) do |row|

	      	code = row.to_hash # exclude the price field
	      	# debugger
	      	a = current_vendor.vendorCodes.create!(:code => code["code"], :name => current_vendor.name , :vendor => current_vendor)#, :instruction => info["instruction"], :help => info["help"], :expiration => info["expiration"])
	      	numberOfCodes = numberOfCodes + 1
	      	date = a.created_at
		end # end CSV.foreach
		history = current_vendor.history
		
	    # temp = date.to_s #+ "," #+ info["description"]+ "," + info["expiration"] + "," + numberOfCodes.to_s + "||||"
	    date = date.to_formatted_s(:long_ordinal)
	    if history == nil
		    # history = "#{date}+++++#{info["comment"]}+++++#{info["expiration"]}+++++#{numberOfCodes.to_s}|||||"
	    	history = "#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    else
	    	# history = "#{history}#{date}+++++#{info["comment"]}+++++#{info["expiration"]}+++++#{numberOfCodes.to_s}|||||"
	    	history = "#{history}#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    end
	    current_vendor.update_attribute(:history, history)
	    if current_vendor.instruction.nil?
	    	current_vendor.update_attribute(:instruction, "")
	    end
	    if current_vendor.expiration.nil?
	    	current_vendor.update_attribute(:expiration, "")
	    end
	    if current_vendor.cashValue.nil?
	    	current_vendor.update_attribute(:cashValue, "1.1")
	    end


  	end # end self.import(file)


  	def self.update_profile_vendor(current_vendor,info)
  		current_vendor.update_attribute(:cashValue, info["cashValue"])
  		current_vendor.update_attribute(:expiration, info["expiration"])
  		current_vendor.update_attribute(:helpLink, info["helpLink"])
  		current_vendor.update_attribute(:instruction, info["instruction"])
  	end # end self.profile()

  	def self.remove_unclaimed_codes(current_vendor)
  		unclaimedCodes=current_vendor.vendorCodes.where(:user_id => nil)
  		unclaimedCodes.each do |code|
  			code.destroy
  		end
  	end

end