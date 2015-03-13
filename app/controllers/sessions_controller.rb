class SessionsController < ApplicationController
  
  def new
    # @user = User.new
    if current_user == nil
      @user = User.new
    else
      if current_user.code == ""
        @user = User.new
      else
        redirect_to '/sessions/offer', notice: "Already register call from sessions#new"
      end
    end
  end

  def enter
    @user = User.new

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
       
      if user.provider == "github"
        redirect_to '/sessions/enter', notice: "Signed in!"
      elsif user.code.nil? || user.code == ""
        session[:user_id] = user.id
        # redirect_to root_url, notice: "Signed in!"
        redirect_to '/sessions/new', notice: "Signed in!"
      else
        session[:user_id]= user.id
        redirect_to '/sessions/offer', notice: "Offer page"
      end
    end
  end


  def offer
    # current_user = User.find(session[:user_id])
    if session[:user_id] != nil
      current_user = User.find(session[:user_id])
      if current_user.code? || current_user.code == ""
        @current_code = params[:code]
        current_user.code = @current_code
        current_user.save!
      else
        @current_code = current_user.code
      end
    end

  end




  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end






































































  def enter
  end

  def hello
  end

  def welcome
  end

  def hello2
  end

  def welcome2
  end

  def hello3
  end

  def welcome3
  end

  def hello4
  end

  def welcome4
  end

  def hello5
  end

  def welcome5
  end

  def hello6
  end

  def welcome6
  end

  def hello1
  end

  def welcome1
  end

  def hello21
  end

  def welcome21
  end

  def hello31
  end

  def welcome31
  end

  def hello41
  end

  def welcome41
  end

  def hello51
  end

  def welcome51
  end

  def hello61
  end

  def welcome61
  end

  def hello2
  end

  def welcome2
  end

  def hello22
  end

  def welcome22
  end

  def hello32
  end

  def welcome32
  end

  def hello42
  end

  def welcome42
  end

  def hello52
  end

  def welcome52
  end

  def hello62
  end

  def welcome62
  end

  def hello12
  end

  def welcome12
  end

  def hello212
  end

  def welcome212
  end

  def hello312
  end

  def welcome312
  end

  def hello412
  end

  def welcome412
  end

  def hello512
  end

  def welcome512
  end

  def hello612
  end

  def welcome612
  end



end
