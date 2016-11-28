class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where("con = 1")
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @exit = Car.where("product_id = #{car_params[:product_id]} and con = 1")
    sql = ActiveRecord::Base.connection() 
    sql.update"update  products  set p_num = p_num -  #{car_params[:c_num]} where id = #{car_params[:product_id]}"
    if  @exit.blank?
      @car = Car.new(car_params)  
     
      if @car.save 
        redirect_to "/products"
      end
    else
      @car = Car.where( "product_id = #{car_params[:product_id]}" ).update_all( "c_num = c_num + #{car_params[:c_num]}")
      redirect_to "/products"
    end 
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def  reduce
    puts params[:id]
    car_num = 0
    @car = Car.where( " id = #{params[:id]} " )
    @car.each  do  |car|
      if  car.c_num  == 1
          Car.delete(params[:id])
         redirect_to  "cars"  
    else
      @car = Car.where( " id = #{params[:id]} " ).update_all( "c_num = c_num - 1")
      @car = Car.where( " id = #{params[:id]} " )
        @car.each  do  |car|
          car_num = car.c_num
        end  
    end
  end
    render  :text  => car_num
  end

  def  add
    car_num = 0
    @car = Car.where( " id = #{params[:id]} " ).update_all( "c_num = c_num + 1")
    @car = Car.where( " id = #{params[:id]} " )
      @car.each  do  |car|
        car_num = car.c_num
      end 
      render  :text  => car_num 
  end

  def  count
    @check_val =  params[:check_val]
    @a = Car.where("id in (#{@check_val})");
    total_money = 0
    puts  @a.blank?
    @a.each  do  |a|
      total_money += a.c_num*Product.find_p_price(a.product_id)
    end
      render  :text  =>  total_money
  end

  def  count_num
    @check_val =  params[:check_val]
    @a = Car.where("id in (#{@check_val})");
    total_num = 0
    @a.each  do  |a|
      total_num += a.c_num
    end
      render  :text  =>  total_num
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:c_num, :product_id)
    end
end
