class Provider < ActiveRecord::Base
	has_many :providerCodes
  	attr_accessible :email, :history, :name, :provider, :usedCodes, :uploadedCodes, :totalCodes, :unclaimCodes, :removedCodes

  	before_create :defaultValue

	def defaultValue
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.totalCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
	end


  	def self.import(file, current_provider, info)
  		numberOfCodes = 0
  		date = ""
    	f = File.open(file.path, "r")
		f.each_line do |row|
			row = row.gsub(/\s+/, "")
			if row !=  ""
		      	a = current_provider.providerCodes.create!(:code => row, :name => current_provider.name , :provider => current_provider)
		      	numberOfCodes = numberOfCodes + 1
		      	date = a.created_at
		    end
		end 
		f.close

		history = current_provider.history
	    date = date.to_formatted_s(:long_ordinal)

	    if history == nil
	    	history = "#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    else
	    	history = "#{history}#{date}+++++#{info["comment"]}+++++#{numberOfCodes.to_s}|||||"
	    end
	    current_provider.update_attribute(:history, history)
	    current_provider.update_attribute(:uploadedCodes, current_provider.uploadedCodes + numberOfCodes)
	    current_provider.update_attribute(:totalCodes, current_provider.totalCodes + numberOfCodes)
	    current_provider.update_attribute(:unclaimCodes, current_provider.unclaimCodes + numberOfCodes)
  	end 


  	def self.remove_unclaimed_codes(current_provider)
  		unclaimedCodes=current_provider.providerCodes.where(:user_id => nil)

  		num = current_provider.unclaimCodes
  		date = Time.now.to_formatted_s(:long_ordinal)

  		history = current_provider.history
  		history = "#{history}#{date}+++++Delete Codes+++++-#{num.to_s}|||||"
  		current_provider.update_attribute(:history, history)


  		contents = "There're #{num} unclaimed codes, remove on #{date}\n\n"
  		unclaimedCodes.each do |code|
  			contents = "#{contents}#{code.code}\n"
  			code.destroy
  		end
  		current_provider.update_attribute(:unclaimCodes, 0)
  		current_provider.update_attribute(:totalCodes, current_provider.totalCodes - num)
  		current_provider.update_attribute(:removedCodes, current_provider.removedCodes + num)
  		return contents
  	end
  	
end
