class RemoveLocationFromWorkshops < ActiveRecord::Migration
  def change
  	remove_column :workshops, :location
  end
end
