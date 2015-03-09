class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def index
    @user = User.find(session[:user_id])
    
  end

  def create
    debugger
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    # @user_name = "hello"
    # redirect_to root_url, notice: "Signed in!"
    redirect_to '/sessions/new', notice: "Signed in!"
    # redend "new"
  end

  def vender
    # redend "new"
  end

  def show
    # @user = User.
    @user = User.find(session[:user_id])
    # session[:user_code] = user.code
    # @user.code = "54321"
    # session[:user_id] = user.id
    # user = User.from_omniauth(env["omniauth.auth"])
    # session[:user_id] = user.id
    # redirect_to session_
  end

  def update
    @user = Movie.find(params[:user_id])


    if @user.update_attributes(params[:user_id])
        redirect_to "/sessions/show"
    else
        render "edit"
    end
  end


  def edit

  end



  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end


end
