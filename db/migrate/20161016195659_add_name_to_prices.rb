class AddNameToPrices < ActiveRecord::Migration
  def change
  	 add_column :prices, :name, :string
  end
end
