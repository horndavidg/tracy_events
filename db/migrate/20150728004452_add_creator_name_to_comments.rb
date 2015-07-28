class AddCreatorNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :creator_name, :string
  end
end
