class AddImageToWorkshop < ActiveRecord::Migration
  def up
    add_attachment :workshops, :image
  end

  def down
    remove_attachment :workshops, :image
  end
end
