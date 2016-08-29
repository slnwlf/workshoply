class ChangeTypeOfWorkshopDescription < ActiveRecord::Migration
  def change
  	change_column :workshops, :description, :text
  end
end
