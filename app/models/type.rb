class Type < ApplicationRecord
  has_many    :books
    validates :b_type,length:{ in: 2..15,  message: '2-15'},  uniqueness:{message:'已经存在此类别'},  :presence => {message: "blank" }
  
  private
  def  self.find_con
    Type.where("con = 1").collect{|t| [t.b_type,t.id]}.insert(0,["请选择",0])
  end
  
  def  self.find_btype(id)
    Type.find_by_sql("select b_type from types where id = #{id}").collect{|t| t.b_type}[0]
  end
  
  def self.to_csv(options = {})  
    CSV.generate(options) do |csv|  
      csv << column_names  
      all.each do |type|  
        csv << type.attributes.values_at(*column_names)  
      end  
    end  
  end

end
