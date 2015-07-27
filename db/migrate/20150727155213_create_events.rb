class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :creator_id
      t.datetime :date
      t.string :duration
      t.string :name
      t.string :address
      t.string :time
      t.string :lat
      t.string :long
      t.text :description

      t.timestamps null: false
    end
  end
end
