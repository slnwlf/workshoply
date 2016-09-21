class AddFormatAndExpectedOutcomesToWorkshops < ActiveRecord::Migration
  def change
  	add_column :workshops, :format, :string
  	add_column :workshops, :expected_outcomes, :string
  end
end
