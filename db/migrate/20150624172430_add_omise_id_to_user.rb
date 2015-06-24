class AddOmiseIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :omise_id, :string
  end
end
