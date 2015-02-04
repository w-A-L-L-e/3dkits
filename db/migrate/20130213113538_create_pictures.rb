class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :pic
      t.string :title

      t.timestamps
    end
  end
end
