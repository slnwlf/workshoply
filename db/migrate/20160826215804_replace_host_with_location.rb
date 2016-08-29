class ReplaceHostWithLocation < ActiveRecord::Migration
  def change
  	rename_column :workshops, :host, :location
  end
end
