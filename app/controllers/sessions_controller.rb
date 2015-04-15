class SessionsController < ApplicationController
  
  def new
    if current_user == nil
      @user = User.new
    else
      if current_user.code == ""
        @user = User.new
      else
        redirect_to '/sessions/customer', notice: "Already register call from sessions#new"
      end
    end
  end


  def create  ## Need to implement whether it's vendor or user
    # user = User.from_omniauth(env["omniauth.auth"])
    auth = request.env["omniauth.auth"]
    
    vendor = Vendor.find_by_provider_and_email(auth["provider"], auth["info"]["email"])

    if vendor != nil
      userVendor=User.find_by_provider_and_email(vendor.provider, vendor.email)
      if userVendor == nil
        User.create(:provider=>vendor.provider, :email => vendor.email, :code => "")
      end
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


  def customer
    if session[:user_id] != nil
      current_user = User.find(session[:user_id])
      if current_user.code.nil? || current_user.code == ""
        #1st time
        @current_code = params[:code]
        current_user.code = @current_code
        current_user.save!  

        @total = 0
        @list_codes = {}
        @instruction = {}
        @help = {}
        @expiration = {}
        @website = {}
        @cashValue = {}
        @vendors = Vendor.all

        @vendors.each do |vendor|
          code = vendor.vendorCodes.where(:user_id=>nil).first
          # debugger
          if code != nil
            code.update_attribute(:user_id, current_user.id)
            # debugger
            @list_codes[vendor.name] = code.code
            @instruction[vendor.name] = vendor.instruction
            @help[vendor.name] = vendor.helpLink
            @expiration[vendor.name] = vendor.expiration
            @website[vendor.name] = vendor.website
            @cashValue[vendor.name] = vendor.cashValue
            @total = @total + vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
          else
            @list_codes[vendor.name] = "We are reloading with sleight of hand"
          end 
          # debugger
        end

      else
        #2nd time
        @current_code = current_user.code
        @list_codes = {}
        @instruction = {}
        @help = {}
        @expiration = {}
        @website = {}
        @cashValue = {}
        @total = 0
        @vendorCodes = VendorCode.where(:user_id => current_user.id)

        @vendorCodes.each do |vendorCode|
          
          @list_codes[Vendor.find(vendorCode.vendor).name] = vendorCode.code
          @instruction[Vendor.find(vendorCode.vendor).name] = vendorCode.vendor.instruction
          @help[Vendor.find(vendorCode.vendor).name] = vendorCode.vendor.helpLink
          @expiration[Vendor.find(vendorCode.vendor).name] = vendorCode.vendor.expiration
          @website[vendorCode.name] = vendorCode.vendor.website
          @cashValue[vendorCode.name] = vendorCode.vendor.cashValue
          @total = @total + vendorCode.vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
        end
      end
    end
    @vendor_user = Vendor.find_by_provider_and_email(current_user.provider, current_user.email)
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

  def change_to_vendor
    redirect_to '/vendors/home', notice: "Change to Vendor Account"
  end

  def hello_user
  end

  def welcome_user
  end

  def enter_user
  end

  def exit_user
  end

  def login_user
  end

  def logout_user
  end


end
