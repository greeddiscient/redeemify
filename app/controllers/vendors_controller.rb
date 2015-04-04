class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    current_vendor=Vendor.find(session[:vendor_id])
    @info = {}
    @info["description"] = params[:codeDescription] 
    @info["instruction"] = params[:instruction]
    @info["help"] = params[:helpLink]
    @info["expiration"] = params[:expiration]

    # current_vendor.update_attribute(:history ="")
    # history = current_vendor.history
    # temp = 
    # history.push(",,,")
    # debugger
    Vendor.import(params[:file], current_vendor,@info)
    
    # history = current_vendor.history
    # temp = 
    # history.push(",,,")

    redirect_to '/vendors/home', notice: "Codes imported"
  end



  def create  ## Need to implement whether it's vendor or user
    # user = User.from_omniauth(env["omniauth.auth"])
    auth = request.env["omniauth.auth"]
    
    vendor = Vendor.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if vendor != nil
      session[:vendor_id]= vendor.id
      redirect_to '/vendors/home', notice: "home page, vendor"
    else
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      if user.code.nil? || user.code == ""
        session[:user_id] = user.id
        # redirect_to root_url, notice: "Signed in!"
        redirect_to '/sessions/new', notice: "Signed in!"
      else
        session[:user_id]= user.id
        redirect_to '/sessions/customer', notice: "Offer page"
      end
    end
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
    end
    @histories_array=[]
  end


  def upload_page
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes.all
  end

  def viewCodes
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes = @vendor.vendorCodes

  end


  def show
  end

  def edit
  end

  def destroy
    session[:vendor_id] = nil
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
