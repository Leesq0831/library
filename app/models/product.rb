class Product < ApplicationRecord
  has_and_belongs_to_many  :car
  has_and_belongs_to_many :order

  private

  def  self.find_p_name(id)
    Product.find_by_sql("select p_name from products where id = #{id}").collect{|t| t.p_name}[0]
  end

  def  self.find_p_price(id)
    Product.find_by_sql("select p_price from products where id = #{id}").collect{|t| t.p_price}[0]
  end

end
