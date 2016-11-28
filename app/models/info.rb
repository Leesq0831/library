class Info < ApplicationRecord
  belongs_to :book
  
  validates :p_time,:numericality => {:greater_than_or_equal_to  =>  1900,
  				    :less_than_or_equal_to  =>  Time.now.year,  
  				    :message => '1900年到当前年'},  
                               :presence => {message: "blank" }
   validates :p_num,:numericality => {:greater_than_or_equal_to  =>  0,
   				    :less_than_or_equal_to  =>  10000,  
   				    :message => '0-10000'},  
                                :presence => {message: "blank" }
   validates :format,:numericality => {:greater_than_or_equal_to  =>  0,
   				    :less_than_or_equal_to  =>  64,  
   				    :message => '0-64'},  
                                :presence => {message: "blank" }
  validates :introduce,  :length  =>  { allow_nil: true,  in: 0..150,  message: '0-150'}
  private

  def  self.find_lan
    ['简体中文','繁體中文','English','Deutsch','日本語','русский','한국어','Français','El español','ภาษาไทย',' عربي']
  end
  
  def  self.find_con
    @info =  Info.all.collect{|t| t.book_id}
    @info = "#{@info}"
    @info = @info[1..-2]

    Book.order("created_at desc").where("id not in (#{@info})").collect{|t| [t.name,  t.id]}
   end
end
