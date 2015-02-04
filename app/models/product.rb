class Product < ActiveRecord::Base

  #TODO: this is now with strong params...
  #attr_accessible :description, :name, :price
  #attr_accessible :pictures_attributes, :category_id
  #has_many :product_pictures, :dependent=>:destroy
  #has_many :pictures, :through => :product_pictures #, :source=>''
  belongs_to :category
  has_many :pictures
  accepts_nested_attributes_for :pictures, :allow_destroy => true 
  # , :reject_if => proc {|attributes| attributes['filename'].blank? && attributes['filename_cache'].blank?}


#accepts_nested_attributes_for :photo, \
#  :reject_if => proc {|attributes| attributes['filename'].blank? \
#    && attributes['filename_cache'].blank?}



  def thumbnail
    if pictures.count>0
      pictures.order("created_at").last.pic.thumb
    else  
      #ActionController::Base.helpers.image_tag("missing.png")
      "/assets/missing.png"
    end
  end

  def first_picture
    if pictures.count>0
      pictures.first.try(:pic).try(:larger)
    else
      "/assets/missing.png"
    end
  end

end
