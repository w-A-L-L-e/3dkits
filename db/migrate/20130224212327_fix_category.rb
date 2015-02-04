class FixCategory < ActiveRecord::Migration
  def change
    create_table :category_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of…" selects:
    add_index :category_hierarchies, [:ancestor_id, :descendant_id], :unique => true

    # For "all ancestors of…" selects
    add_index :category_hierarchies, [:descendant_id]

    Category.reset_column_information
    #CategoryHierarchy.reset_column_information
    #Category.rebuild!

    add_column :categories, :position, :integer
  end
end

