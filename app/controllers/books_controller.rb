class BooksController < ApplicationController

  before_filter :authenticate_user!
  
  def  new
    @book  =  Book.new 
  end

  def  index
    if  !params[:user_id].nil?
      @borrow  =  Book.find_by_sql("select * from borrow where ubn>0 and user_id = #{params[:user_id]}").collect{|t| t.book_id}
      @borrow  =  "#{@borrow}"
      @borrow  =  @borrow[1..-2]

      @book  =   Book.paginate( :page  =>  params[:page]||1,
                                                           :per_page  =>  5).order("created_at").where("con = 1 and id in (#{@borrow})")
      @books = nil
    else

      @type =  Type.where("b_type like '%#{params[:search]}%'").collect{|t| t.id}
      @type = "#{@type}"
      @type = @type[1..-2]
      if @type.size  ==  0
        @type  = 0
      end

      @info  =  Info.where("author  like '%#{params[:search]}%'").collect{|t|  t.book_id}
      @info  =  "#{@info}"
      @info  =  @info[1..-2]
      if @info.size  ==  0
        @info  = 0
      end

      @infos  =  Info.where("p_time  like '%#{params[:search]}%'").collect{|t|  t.book_id}
      @infos  =  "#{@infos}"
      @infos  =  @infos[1..-2]
      if @infos.size  ==  0
        @infos  = 0
      end

  	if  params[:search] .nil?
  	   @books = Book.paginate( :page  =>  params[:page]||1,
  	                                                       :per_page  =>  5).order("type_id").where("con = 1")
  	  elsif   params[:se_t]  ==  'name'
  	    @books = Book.paginate( :page  =>  params[:page]||1,
  	                                                        :per_page  =>  5).order("created_at desc").where("con = 1  and  name  like  '%#{params[:search]}%'")
  	  elsif   params[:se_t]  ==  'b_type'  
  	    @books = Book.paginate( :page  =>  params[:page]||1,
                                                                :per_page  =>  5).order("created_at desc").where("con = 1  and  type_id  in (#{@type})")
        elsif  params[:se_t]  ==  'all'   

          @books = Book.paginate( :page  =>  params[:page]||1,
  	                                                      :per_page  =>  5).order("created_at desc").where("con = 1  and (type_id  in (#{@type})  
                                                                                                                                                               or   id in(#{@info}) or  id in(#{@infos}) 
                                                                                                                                                               or   name  like  '%#{params[:search]}%')")
        elsif  params[:se_t]  ==  'author'
          @books  =   Book.paginate( :page  =>  params[:page]||1,
                                                                 :per_page  =>  5).order("created_at desc").where("con = 1  and  id in(#{@info}) ")
        else
          @books  =   Book.paginate( :page  =>  params[:page]||1,
                                                                 :per_page  =>  5).order("created_at desc").where("con = 1  and  id in(#{@infos}) ")  
  	  end
    end
  end	

  def  create
    @b = book_params[:name]
    @book = Book.new(book_params)
    if @book.valid?  &&  @book.save
      redirect_to "/types/#{book_params[:type_id]}"
   else
       render 'new'
    end
  end

  def  update 

    sql = ActiveRecord::Base.connection() 
    print b_params[:user_id],"user_id  value"
    puts  params[:num]

    if  params[:num]  ==  "1"
      @book = Book.where( " id = #{params[:id]} " ).update_all( "num = num + 1, bn = bn - 1")
      sql.update"update  borrow  set ubn = ubn - 1  where  book_id = #{params[:id]} and user_id = #{b_params[:user_id]}"
      
      redirect_to "/types/#{book_params[:type_id]}"

    elsif  params[:num]  ==  "0" 

       @book = Book.where( " id  = #{params[:id]} " ).update_all( "num = num - 1, bn = bn + 1") 
        if  find_c_exit(params[:id],b_params[:user_id]) > 0
           sql.update"update  borrow  set ubn = ubn + 1  where  book_id = #{params[:id]} and user_id = #{b_params[:user_id]}"
         else
          sql.insert"insert into borrow(ubn,book_id,user_id)  values(1,#{params[:id]},  #{b_params[:user_id]})"
        end
        redirect_to "/types/#{book_params[:type_id]}"
    elsif  params[:num]  ==  "2"

       @book = Book.where( " id = #{params[:id]} " ).update_all( "num = num + #{b_params[:bn]}, bn = bn - #{b_params[:bn]}")
       sql.update"update  borrow  set ubn = ubn - #{b_params[:bn]}  where   book_id = #{params[:id]} and user_id = #{b_params[:user_id]}"
       redirect_to "/books/#{params[:id]}"

    elsif  params[:num]  ==  "3"
       @book = Book.where( " id = #{params[:id]} " ).update_all( "num = num - #{b_params[:bn]}, bn = bn + #{b_params[:bn]}" )
        if  find_c_exit(params[:id],b_params[:user_id]) > 0
           sql.update"update  borrow  set ubn = ubn +  #{b_params[:bn]}  where
                                      book_id = #{params[:id]} and user_id = #{b_params[:user_id]}"
         else
          sql.insert"insert into borrow(ubn,book_id,user_id)  
                                values(#{b_params[:bn]},#{params[:id]},  #{b_params[:user_id]})"
        end
       redirect_to "/books/#{params[:id]}"
    else

       @book = Book.find(params[:id])
       if @book.update(book_params)
         redirect_to "/books/#{params[:id]}"
       else
         render 'edit'
       end
    end
  end

  def  edit
    @book  =  Book.find(params[:id])
  end

  def  destroy
    @book =  Book.where( " id  = #{params[:id]} " ).update_all( "con = 0 ")
    redirect_to :back
  end

  def  show
    @books  =  Book.find(params[:id])
    @info  =  Info.where("book_id = #{params[:id]}")
  end

  def  checktypeid
    type_id  =  params[:type_id]
    render :text => infoadd(type_id)
  end

  def  infoadd(type_id)
    @info =  Info.all.collect{|t| t.book_id}
    @info = "#{@info}"
    puts  @info
    @info = @info[1..-2]

    options = ""
    books = Book.order("created_at desc").where("type_id =  #{type_id} and id not in (#{@info}) ")
    books.each do |book|
      options << "<option value='#{book.id}'>#{book.name}</option>"
    end
    return options
  end

  def  checkname
    puts params[:name]
    book = Book.find_by_name(params[:name])
    if  book.nil?
      render  :text  =>  true
    else 
      render  :text  =>  false
    end
  end

  def  batch_add
    params.permit!
    params[:book].each  do  |b|
      @book = Book.create(b)
    end
    redirect_to  :back
  end

  private 
    def  book_params
      params.require(:book).permit(:name,  :num,  :type_id,  :picture)
    end

    def  b_params
      params.require(:book).permit(:name,  :num,  :type_id,  :bn,  :user_id)
    end

    def  find_c_exit(id1,id2)
      Book.find_by_sql("select b.ubn from  borrow b  where b.book_id = #{id1} and b.user_id = #{id2}").size
    end
end