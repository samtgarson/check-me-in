class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :address
      t.string :name
      t.string :emoji
      t.string :foursquare_id
      t.string :mondo_id, index: true

      t.timestamps null: false
    end
  end
end
