class ProvidersController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/providers/upload_page', :flash => { :error => "You have not upload a file" }
    else
      current_provider=Provider.find(session[:provider_id])
      @info = {}
      @info["comment"] = params[:comment] 
      
      Provider.import(params[:file], current_provider,@info)
    
      redirect_to '/providers/home', notice: "Codes imported"
    end
  end


# ---------------
  def home
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes

    @totalCodes = @providerCodes.count
    @codesRemain = @providerCodes.where(:user_id => nil).count
    @codesUsed = @totalCodes - @codesRemain


    @histories = @provider.history
    if @histories != nil
      @histories = @histories.split("|||||")

      @histories_array=[]
      @histories.each do |history|
        temp = history.split("+++++")
        @histories_array.push(temp)
      end
    else
      @histories_array=[]
    end
    @histories_array.reverse!
  end


  def upload_page
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes.all
  end


  def remove_codes
    current_provider=Provider.find(session[:provider_id])
    flag = current_provider.providerCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/providers/home ', :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Provider.remove_unclaimed_codes(current_provider)
      # redirect_to '/providers/home', notice: "Unclaimed Codes Successfully Removed"
      send_data contents,  :filename => "Unclaimed_Codes.txt"
    end
  end

  def clear_history
    current_provider=Provider.find(session[:provider_id])
    if current_provider.history.nil?
      redirect_to '/providers/home', :flash => { :error => "History is empty" }
    else  
      current_provider.update_attribute(:history, nil)
      redirect_to '/providers/home', notice: "Cleared History"
    end
  end
 


  def show
  end

  def edit
  end



  def hello
  end

  def welcome
  end

  def enter
  end

  def exit
  end

  def login
  end

  def logout
  end


end
