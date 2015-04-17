class ProvidersController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/providers/upload_page', notice: "You have not upload a file"
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

    @codesRemain = @providerCodes.where(:user_id => nil).count
    @codesUsed = @providerCodes.count - @codesRemain


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
  end


  def upload_page
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes.all
  end


  def remove_codes
    current_provider=Provider.find(session[:provider_id])
    Provider.remove_unclaimed_codes(current_provider)
    redirect_to '/providers/home', notice: "Unclaimed Codes Successfully Removed"
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
