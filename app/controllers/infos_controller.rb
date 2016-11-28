class InfosController < ApplicationController

  def  new
    @info  =  Info.new 
  end
  
  def  create
      @info = Info.new(info_params)
      if @info.valid?  && @info.save
    
       redirect_to "/books/#{info_params[:book_id]}"
     else
      render 'new'
    end
  end

  def  edit
    @info  =  Info.find(params[:id])
  end

  def  update
    @info = Info.find(params[:id])
    
     if @info.update(info_params)
       redirect_to "/books/#{info_params[:book_id]}"
     else
       render 'edit'
     end
  end

  private
  def  info_params
    params.require(:info).permit(:author,  :p_place,  :p_time,  
    	                                                      :p_num,  :language,  :format,  
    	                                                      :introduce,  :book_id)
  end
end
