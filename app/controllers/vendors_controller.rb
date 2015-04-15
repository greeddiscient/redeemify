class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    current_vendor=Vendor.find(session[:vendor_id])
    @info = {}
    @info["comment"] = params[:comment] 
    # @info["instruction"] = params[:instruction]
    # @info["help"] = params[:helpLink]
    # @info["expiration"] = params[:expiration]

    # current_vendor.update_attribute(:history ="")
    # history = current_vendor.history
    # temp = 
    # history.push(",,,")
    # debugger
    Vendor.import(params[:file], current_vendor,@info)
  
    redirect_to '/vendors/home', notice: "Codes imported"
  end


# ---------------
  def home
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes

    @codesRemain = @vendorcodes.where(:user_id => nil).count
    @codesUsed = @vendorcodes.count - @codesRemain


    @histories = @vendor.history
    if @histories != nil
      @histories = @histories.split("|||||")


      # @history1 = histories[0].split("+++++")

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
