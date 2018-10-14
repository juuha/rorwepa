class AddClosedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :closed, :boolean
  end
end
