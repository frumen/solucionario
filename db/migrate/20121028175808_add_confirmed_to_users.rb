class AddConfirmedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :integer, default: 0
  end
end
