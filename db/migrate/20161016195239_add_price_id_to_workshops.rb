class AddPriceIdToWorkshops < ActiveRecord::Migration
  def change
  	add_column :workshops, :price_id, :integer
  end
end
