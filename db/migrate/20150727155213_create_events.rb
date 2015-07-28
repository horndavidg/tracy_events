class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :creator_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :start_time
      t.string :end_time
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
