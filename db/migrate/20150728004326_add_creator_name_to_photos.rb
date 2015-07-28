class AddCreatorNameToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :creator_name, :string
  end
end
