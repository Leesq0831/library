class TypesController < ApplicationController

  before_filter :authenticate_user!
  
   def  deletecheck 
     if   params[:type_ids].nil?
     else
       params[:type_ids].each  do  |ids|
       @type = Type.where( " id  = #{ids} " ).update_all( "con = 0 ")
       end
     end
     redirect_to  :back
   end

  def  new
      @type  =  Type.new 
    end

    def  index
      @types = Type.paginate( :page  =>  params[:page]||1,
                                                        :per_page  =>  5).order("created_at desc").where("con = 1")
      
      respond_to do |format|  
        format.html # index.html.erb  
        format.csv { send_data @types.to_csv }  
        format.xls  
          #    format.xls { send_data @week_plans.to_csv(col_sep: "\t") }  
        format.json { render :json => @types }  
          end
    end
    
     def  create
       @type = Type.new(type_params)
       
       if  @type.save
        redirect_to types_path
       else
          render 'new'
       end 
     end

     def  show
      puts  params[:id]
      params[:id] = params[:id].to_i
        @books  =  Book.paginate( :page  =>  params[:page]||1,
                                                              :per_page  =>  5).order("created_at desc").where("type_id = #{params[:id]}  and  con = 1")
     end

      def  edit
        @type  =  Type.find(params[:id])
      end

      def  update
        @type = Type.find(params[:id])
       
        if @type.update(type_params)
          redirect_to types_path
        else
          render 'edit'
        end
      end

    def  destroy
      if  params[:id]  ==  "a"
        @id = Type.find_by_sql("select c.id from (select types.id ,COUNT(case when books.con = 1 then 1 end) as count
                                                       from types left JOIN books on types.id = books.type_id GROUP BY types.id)c where c.count = 0").collect{|t|  t.id}
        @id = "#{@id}"
        @id = @id[1..-2]
        @type = Type.where( " id in (#{@id})" ).update_all( "con = 0 ")
        redirect_to "/types"
      elsif  params[:id]  == "b"
        @type = Type.where( " con = 0" ).update_all( "con = 1 ")
        redirect_to "/types"
      else
        @type = Type.where( " id  = #{params[:id]} " ).update_all( "con = 0 ")
        redirect_to :back
      end
    end
    
  private
    def  type_params
    	params.require(:type).permit(:b_type)
    end 
end
