class AddEventIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :event_id, :string
  end
end
