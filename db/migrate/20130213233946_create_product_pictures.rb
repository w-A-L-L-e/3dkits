class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.integer :product_id
      t.integer :picture_id
      t.string :title

      t.timestamps
    end
  end
end
