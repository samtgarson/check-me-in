class AddCategoriesToUserAndMerchant < ActiveRecord::Migration
  def change
    add_column :users, :categories, :string
    add_column :merchants, :category, :string
  end
end
