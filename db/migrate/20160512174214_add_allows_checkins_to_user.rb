class AddAllowsCheckinsToUser < ActiveRecord::Migration
  def change
    add_column :users, :allows_checkins, :boolean, default: true
  end
end
