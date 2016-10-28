class RemovePriceIdFromWorkshops < ActiveRecord::Migration
  def change
  	remove_column :workshops, :price_id
  end
end
