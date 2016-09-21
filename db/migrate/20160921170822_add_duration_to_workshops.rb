class AddDurationToWorkshops < ActiveRecord::Migration
  def change
  	add_column :workshops, :duration, :string
  end
end
