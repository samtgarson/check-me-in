class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :merchant, index: true, foreign_key: true
      t.string :data
      t.string :mondo_id, index: true

      t.timestamps null: false
    end
  end
end
