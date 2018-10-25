class AddColumnToWorkshop < ActiveRecord::Migration
  def change
  	add_column :workshops, :featured, :boolean, default: false
  end
end
