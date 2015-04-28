class ProvidersController < ApplicationController

  def index
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/providers/upload_page', :flash => { :error => "You have not upload a file" }
    else
      current_provider=Provider.find(session[:provider_id])
      @info = {}
      @info["comment"] = params[:comment] 
      
      Provider.import(params[:file], current_provider,@info)
    
      redirect_to '/providers/home', notice: "Codes imported"
    end
  end


# ---------------
  def home
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes


    @histories = @provider.history
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



    # GoogleChart::BarChart.new("600x180", "Codes Data", :horizontal, false) do |bc|
    #   bc.data "# codes uploaded", [@provider.uploadedCodes], '080dcc'
    #   bc.data "Current of Total code = sum of #codes remaining and #codes used", [@provider.totalCodes], 'a1731d' 
    #   bc.data "# codes used", [@provider.usedCodes], 'c53711' 
    #   bc.data "# codes remaining", [@provider.unclaimCodes], '0c9200'
    #   bc.data "# codes removed", [@provider.removedCodes], '000000'
    #   bc.show_legend = true
    #   bc.stacked = false
    #   bc.data_encoding = :extended

    #   bc.axis :x , :range => [0,@provider.uploadedCodes]
    #   @graph =  bc.to_url
    # end

    @hash = {"uploaded" => @provider.uploadedCodes, "total" => @provider.totalCodes, "used" => @provider.usedCodes, "unclaim" => @provider.unclaimCodes, "removed" => @provider.removedCodes }
    gon.codes = @hash





  end


  def upload_page
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes.all
  end


  def remove_codes
    current_provider=Provider.find(session[:provider_id])
    flag = current_provider.providerCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/providers/home ', :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Provider.remove_unclaimed_codes(current_provider)
      # redirect_to '/providers/home', notice: "Unclaimed Codes Successfully Removed"
      send_data contents,  :filename => "Unclaimed_Codes.txt"
    end
  end

  def clear_history
    current_provider=Provider.find(session[:provider_id])
    if current_provider.history.nil?
      redirect_to '/providers/home', :flash => { :error => "History is empty" }
    else  
      current_provider.update_attribute(:history, nil)
      redirect_to '/providers/home', notice: "Cleared History"
    end
  end
 


  def show
  end

  def edit
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
