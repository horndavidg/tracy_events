class AddCreatorNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_name, :string
  end
end
