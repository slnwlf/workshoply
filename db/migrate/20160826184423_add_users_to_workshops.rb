class AddUsersToWorkshops < ActiveRecord::Migration
  def change
  	add_column :workshops, :user_id, :integer
  end
end
