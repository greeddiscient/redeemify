require 'rubygems'
require 'google_chart'

class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/vendors/upload_page', :flash => { :error => "You have not upload a file" }
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

   
    if @vendor.instruction.nil? || @vendor.description.nil? ||@vendor.helpLink.nil? || @vendor.cashValue.nil? || @vendor.expiration.nil?
      redirect_to '/vendors/profile', :flash => { :error => "Please complete all fields of your profile" }
    else
      

      @histories = @vendor.history
      if @histories != nil
        @histories = @histories.split("|||||")



        @histories_array=[]
        @histories.each do |history|
          temp = history.split("+++++")
          @histories_array.push(temp)
        end
        @histories_array.reverse!
      else
        @histories_array=[]
      end
    end


    @hash = {"uploaded" => @vendor.uploadedCodes, "total" => @vendor.totalCodes, "used" => @vendor.usedCodes, "unclaim" => @vendor.unclaimCodes, "removed" => @vendor.removedCodes }
    gon.codes = @hash

  end


  def upload_page
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes.all
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
    cash = params[:cashValue]
    cash = cash.gsub(/\s+/, "")
    if cash != ""
      @info["cashValue"] = cash
    end
    if params[:instruction] != ""
      @info["instruction"] = params[:instruction]
    end
    if params[:description] != ""
      @info["description"] = params[:description]
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

  def remove_codes   #:usedCodes, :uploadedCodes, :totalCodes, :unclaimCodes, :removedCodes
    current_vendor=Vendor.find(session[:vendor_id])
    flag = current_vendor.vendorCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/vendors/home', :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Vendor.remove_unclaimed_codes(current_vendor)
      send_data contents,  :filename => "Unclaimed_Codes.txt" 
    end
  end


  def clear_history
    current_vendor=Vendor.find(session[:vendor_id])
    if current_vendor.history.nil?
      redirect_to '/vendors/home', :flash => { :error => "History is empty" }
    else  
      current_vendor.update_attribute(:history, nil)
      redirect_to '/vendors/home', notice: "Cleared History"
    end
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


  def destroy
    session[:user_id] = nil
    session[:vendor_id] = nil
    session[:provider_id] = nil
    gon.clear
    redirect_to root_url, notice: "Signed out!"
  end



end
