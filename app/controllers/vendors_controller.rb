class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/vendors/upload_page', notice: "You have not upload a file"
    else
      current_vendor=Vendor.find(session[:vendor_id])
      @info = {}
      @info["comment"] = params[:comment] 
      Vendor.import(params[:file], current_vendor,@info)
    
      redirect_to '/vendors/home', notice: "Codes imported"
    end
  end


# ---------------
  def home
    @vendor = Vendor.find(session[:vendor_id])
    if @vendor.instruction.nil? || @vendor.helpLink.nil? || @vendor.cashValue.nil? || @vendor.expiration.nil?
      redirect_to '/vendors/profile', notice: "Please complete all fields of your profile"
    # elsif @vendor.vendorCodes.where(:user_id => nil).count == 0
    #   redirect_to '/vendors/upload_page', notice: "you have 0 remmaining codes, please upload codes"
    else
      @vendorcodes= @vendor.vendorCodes

      @codesRemain = @vendorcodes.where(:user_id => nil).count
      @codesUsed = @vendorcodes.count - @codesRemain


      @histories = @vendor.history
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
  end


  def upload_page
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes.all
  end

  def viewCodes
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes = @vendor.vendorCodes

  end

  def profile
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes = @vendor.vendorCodes.all
  end

  def update_profile
    current_vendor=Vendor.find(session[:vendor_id])
    if current_vendor.cashValue.nil?
      current_vendor.update_attribute(:cashValue, "0")
    end

    @info = {}
    if params[:cashValue] != ""
      @info["cashValue"] = params[:cashValue]
    end
    if params[:instruction] != ""
      @info["instruction"] = params[:instruction]
    end
    if params[:helpLink] != ""
      @info["helpLink"] = params[:helpLink]
    end
    if params[:expiration] != ""
      @info["expiration"] = params[:expiration]
    end
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
    if current_user.nil?
     current_user =  User.create!(:provider => current_vendor.provider, :name => current_vendor.name, :email => current_vendor.email)
    end
    session[:user_id]=current_user.id
    if current_user.code == nil #|| current_user.code==""
      redirect_to '/sessions/new', notice: "Changed to user account"
    else
      redirect_to '/sessions/customer', notice: "Changed to user account"
    end
  end



  def show
  end

  def edit
  end

  def destroy
    session[:user_id] = nil
    session[:vendor_id] = nil
    session[:provider_id] = nil
    redirect_to root_url, notice: "Signed out!"
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
