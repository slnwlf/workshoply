class DropPricesTable < ActiveRecord::Migration
  def change
  	drop_table :prices
  end
end
