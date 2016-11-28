class Car < ApplicationRecord
  has_and_belongs_to_many :product
  has_and_belongs_to_many :order

  private 
  def  self.count_num
    count = 0
    @car = Car.where("con = 1")
    @car.each  do  |car|
        count += car.c_num
    end
    return count
  end
  def  self.count_money
    total = 0
    @car = Car.where("con = 1")
    @car.each  do  |car|
    	
    	#puts car.c_num*Product.find_p_price(car.product_id)
      total += car.c_num*Product.find_p_price(car.product_id)
    end
    return total
  end

  def  self.find_pro_id(ids)

    @car = Car.where("id in (#{ids}) and con = 0").collect{|t| t.product_id}
    @car = "#{@car}"
    @car = @car[1..-2]
    @product = Product.where("id in (#{@car})").collect{|t| t.p_name}
    p_n = ""
    @product.each  do  |p|
      p_n += (p +"      ")
    end
    return  p_n
  end

  def  self.setcar_con(ids)
    @car = Car.where("id in  (#{ids})").update_all("con = 0")
  end

  def  self.reducenum(ids)
    @car = Car.where("id in (#{ids}) and con = 0  and p_con = 3").collect{|t| [t.product_id,  t.c_num]}

    puts @car[0][1]
  end


end
