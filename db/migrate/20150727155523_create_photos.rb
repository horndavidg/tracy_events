class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :creator_id
      t.string :url
      t.string :description

      t.timestamps null: false
    end
  end
end
