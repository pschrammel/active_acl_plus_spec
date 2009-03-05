class CreateBaseTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login, :string, :null => false
      t.column :type, :string
    end
    
    add_index :users, :login, :unique
    add_index :users, :type
  
    create_table :forums do |t|
      t.column :name, :string, :null => false
      t.column :tag, :string
      t.column :type, :string
      t.column :category_id, :integer, :null => false    
    end
    
    add_index :forums, :type
    add_index :forums, :category_id 
    
    create_table :user_groups do |t|
      t.column :description, :string, :null => false
      t.column :lft, :integer, :null => false
      t.column :rgt, :integer, :null => false
      t.column :parent_id, :integer
    end
    
    add_index :user_groups, :lft
    add_index :user_groups, :rgt
    
    create_table :user_groups_users, :id => false do |t|
      t.column :user_id, :integer, :null => false
      t.column :user_group_id, :integer, :null => false
    end
    
    add_index :user_groups_users, [:user_id, :user_group_id], :unique
    add_index :user_groups_users, :user_group_id
    
    create_table :categories do |t|
      t.column :description, :string, :null => false
      t.column :lft, :integer, :null => false
      t.column :rgt, :integer, :null => false
      t.column :parent_id, :integer
    end
    
    add_index :categories, :lft
    add_index :categories, :rgt

    create_table :pages do |t|
      t.column :title, :string, :null => false
      t.column :content, :text
    end
    add_index :pages,:title

    create_table :companies do |t|
      t.column :name, :string, :null => false
    end
    add_index :companies,:name
  end
  
  def self.down
	drop_table :users
	drop_table :forums
	drop_table :user_groups
	drop_table :categories
	drop_table :user_groups_users
  end
end
