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

    # GoogleChart::BarChart.new("600x180", "Codes Data", :horizontal, false) do |bc|
    #   bc.data "# codes uploaded", [@vendor.uploadedCodes], '080dcc'
    #   bc.data "Current of Total code = sum of #codes remaining and #codes used", [@vendor.totalCodes], 'a1731d' 
    #   bc.data "# codes used", [@vendor.usedCodes], 'c53711' 
    #   bc.data "# codes remaining", [@vendor.unclaimCodes], '0c9200'
    #   bc.data "# codes removed", [@vendor.removedCodes], '000000'
    #   bc.show_legend = true
    #   bc.stacked = false
    #   bc.data_encoding = :extended
    #   bc.shape_marker :circle, :color => "000000", :data_set_index => 2, :data_point_index => 4, :pixel_size => 10
    #   bc.axis :x , :range => [0,@vendor.uploadedCodes]
    #   @graph =  bc.to_url
    # end

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
      # redirect_to '/vendors/home', notice: "Unclaimed Codes Successfully Removed"
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
