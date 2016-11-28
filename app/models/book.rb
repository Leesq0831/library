class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_one :info
  belongs_to :type
  
  validates  :num,  :numericality => {:greater_than_or_equal_to  =>  0,  :message => '需大于等于0'},  :presence => {message: "blank" }
  validates  :name,  length:{ in: 1..50,  message: '1-50字符'},  uniqueness:{message:'已经存在此书籍'},  :presence => {message: "blank" }
  validates  :picture,  :format  =>  {:with  =>  /\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/,  :multiline => true,  :message  =>  'must be a url for git,jpg or png  image'  }
  private
  def  self.con(id)
    Book.where("type_id = #{id}").count(1)
  end
  
  #获取借出本书
  def  self.find_ubn(id1,id2)
   Book.find_by_sql("select b.ubn from  borrow b  where b.book_id = #{id1} and b.user_id = #{id2}").collect{|t| t.ubn}[0]
  end

  def  self.find_ubn_e(id1,id2)
   Book.find_by_sql("select b.ubn from  borrow b  where b.book_id = #{id1} and b.user_id = #{id2}").size
  end

end
