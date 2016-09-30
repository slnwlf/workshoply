class AddBioToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :link_to_bio, :string
  end
end
