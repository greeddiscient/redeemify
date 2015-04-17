class Provider < ActiveRecord::Base
	has_many :providerCodes
  	attr_accessible :email, :history, :name, :provider

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
  	end # end self.import(file)


  	def self.remove_unclaimed_codes(current_provider)
  		unclaimedCodes=current_provider.providerCodes.where(:user_id => nil)
  		unclaimedCodes.each do |code|
  			code.destroy
  		end
  	end
  	
end
