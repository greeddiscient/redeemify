class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end


  def home
    @vendor = Vendor.find(session[:vendor_id])
  end

  def show
  end

  def edit
  end


  def destroy
    session[:vendor_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end































































  def hello3
  end

  def welcome3
  end

  def hello23
  end

  def welcome23
  end

  def hello33
  end

  def welcome33
  end

  def hello43
  end

  def welcome43
  end

  def hello53
  end

  def welcome53
  end

  def hello63
  end

  def welcome63
  end

  def hello13
  end

  def welcome13
  end

  def hello213
  end

  def welcome213
  end

  def hello313
  end

  def welcome313
  end

  def hello413
  end

  def welcome413
  end

  def hello513
  end

  def welcome513
  end

  def hello613
  end

  def welcome613
  end

  def hello23
  end

  def welcome23
  end

  def hello223
  end

  def welcome223
  end

  def hello323
  end

  def welcome323
  end

  def hello423
  end

  def welcome423
  end

  def hello523
  end

  def welcome523
  end

  def hello623
  end

  def welcome623
  end

  def hello123
  end

  def welcome123
  end

  def hello2123
  end

  def welcome2123
  end

  def hello3123
  end

  def welcome3123
  end

  def hello4123
  end

  def welcome4123
  end

  def hello5123
  end

  def welcome5123
  end

  def hello6123
  end

  def welcome6123
  end


end
