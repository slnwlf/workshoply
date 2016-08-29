class AddSlugToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :slug, :string
    add_index :workshops, :slug, unique: true
  end
end
