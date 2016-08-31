class AddTopicIdToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :topic_id, :integer
  end
end
