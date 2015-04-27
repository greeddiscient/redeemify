class Vendor < ActiveRecord::Base 
	# require 'csv'
	has_many :vendorCodes
	attr_accessible :history, :provider, :email, :name , :description, :instruction, :website, :comment , :helpLink, :expiration, :cashValue, :usedCodes, :uploadedCodes, :totalCodes, :unclaimCodes, :removedCodes
	before_create :defaultValue

	def defaultValue
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.totalCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
	end

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
	    current_vendor.update_attribute(:uploadedCodes, current_vendor.uploadedCodes + numberOfCodes)
	    current_vendor.update_attribute(:totalCodes, current_vendor.totalCodes + numberOfCodes)
	    current_vendor.update_attribute(:unclaimCodes, current_vendor.unclaimCodes + numberOfCodes)


  	end # end self.import(file)


  	def self.update_profile_vendor(current_vendor,info)
  		current_vendor.update_attributes(:cashValue => info["cashValue"], :expiration => info["expiration"], :helpLink => info["helpLink"],:instruction => info["instruction"], :description => info["description"])
  	end # end self.profile()

  	def self.remove_unclaimed_codes(current_vendor)
  		unclaimedCodes=current_vendor.vendorCodes.where(:user_id => nil)
  		num = current_vendor.unclaimCodes
  		date = Time.now.to_formatted_s(:long_ordinal)

  		history = current_vendor.history
  		history = "#{history}#{date}+++++Delete Codes+++++-#{num.to_s}|||||"
  		current_vendor.update_attribute(:history, history)

  		contents = "There're #{num} unclaimed codes, remove on #{date}\n\n"
  		unclaimedCodes.each do |code|
  			contents = "#{contents}#{code.code}\n"
  			code.destroy
  		end
  		current_vendor.update_attribute(:unclaimCodes, 0)
  		current_vendor.update_attribute(:totalCodes, current_vendor.totalCodes - num)
  		current_vendor.update_attribute(:removedCodes, current_vendor.removedCodes + num)

  		return contents
  	end

end