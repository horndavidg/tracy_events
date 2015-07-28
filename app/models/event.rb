class Event < ActiveRecord::Base

	#make sure to add back :start_date and :end_date to this validation after seed data is no longer needed!
	validates :description, :name, :long, :lat, :address, :start_time, :end_time, :creator_id, presence: true
	has_many :event_users, dependent: :destroy
	has_many :users, through: :event_users

	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy
end
