class AddDurationIdToWorkshops < ActiveRecord::Migration
  def change
  	  add_column :workshops, :duration_id, :integer
  end
end
