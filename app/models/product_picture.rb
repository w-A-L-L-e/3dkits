class ProductPicture < ActiveRecord::Base
  #attr_accessible :picture_id, :product_id, :title

  belongs_to :product
  belongs_to :picture
end


