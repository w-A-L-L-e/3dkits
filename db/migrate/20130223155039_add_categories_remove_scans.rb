class AddCategoriesRemoveScans < ActiveRecord::Migration
  def up
    create_table "categories", :force => true do |t|
      t.integer  "parent_id"
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "menu_label"
      t.boolean  "is_koopje",      :default => false
      t.boolean  "alle_veilingen", :default => false
      t.boolean  "alle_koopjes",   :default => false
    end
    create_table "category_translations", :force => true do |t|
      t.integer  "category_id"
      t.string   "locale"
      t.string   "title"
      t.string   "menu_label"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"

  end

  def down
    drop_table :categories
  end
end
