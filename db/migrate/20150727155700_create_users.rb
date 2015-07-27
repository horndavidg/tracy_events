class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at
      t.string :google_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
