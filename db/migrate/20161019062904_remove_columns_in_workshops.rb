class RemoveColumnsInWorkshops < ActiveRecord::Migration
  def change
  	remove_column :workshops, :duration
  	remove_column :workshops, :format
  end
end
