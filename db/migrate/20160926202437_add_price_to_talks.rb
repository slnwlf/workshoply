class AddPriceToTalks < ActiveRecord::Migration
  def change
  	 add_column :workshops, :price, :integer
  end
end
