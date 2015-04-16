class ProvidersController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    current_provider=Provider.find(session[:provider_id])
    @info = {}
    @info["comment"] = params[:comment] 
    
    Provider.import(params[:file], current_provider,@info)
  
    redirect_to '/providers/home', notice: "Codes imported"
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
    @provider = Provider.find(session[:vendor_id])
    @providerCodes= @provider.providerCodes.all
  end


  def profile
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes = @vendor.vendorCodes.all
  end

  def update_profile
    current_vendor=Vendor.find(session[:vendor_id])
    @info = {}
    @info["cashValue"] = params[:cashValue]
    @info["instruction"] = params[:instruction]
    @info["helpLink"] = params[:helpLink]
    @info["expiration"] = params[:expiration]
    Vendor.update_profile_vendor(current_vendor,@info)
    redirect_to '/vendors/home', notice: "Profile Updated"
  end

  def remove_codes
    current_vendor=Vendor.find(session[:vendor_id])
    Vendor.remove_unclaimed_codes(current_vendor)
    redirect_to '/vendors/home', notice: "Unclaimed Codes Successfully Removed"
  end

  def change_to_user
    current_vendor=Vendor.find(session[:vendor_id])
    current_user=User.find_by_provider_and_email(current_vendor.provider, current_vendor.email)
    session[:user_id]=current_user.id
    if current_user.code == nil || current_user.code==""
      redirect_to '/sessions/new', notice: "Changed to user account"
    else
      redirect_to '/sessions/customer', notice: "Changed to user account"
    end
  end



  def show
  end

  def edit
  end

  # def destroy
  #   session[:vendor_id] = nil
  #   redirect_to root_url, notice: "Signed out!"
  # end

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
