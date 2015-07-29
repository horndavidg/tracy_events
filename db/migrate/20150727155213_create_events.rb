class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :creator_id
      t.datetime :start_date
      t.datetime :end_date
      t.time :start_time
      t.time :end_time
      t.string :name
      t.string :address
      t.string :lat
      t.string :long
      t.text :description

      t.timestamps null: false
    end
  end
end
