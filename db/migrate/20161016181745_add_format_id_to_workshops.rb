class AddFormatIdToWorkshops < ActiveRecord::Migration
  def change
  	add_column :workshops, :format_id, :integer
  end
end