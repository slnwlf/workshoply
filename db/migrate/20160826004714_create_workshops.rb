class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|

      t.string :title
      t.string :description
      t.string :host


      t.timestamps null: false
    end
  end
end
