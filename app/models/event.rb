class Event < ActiveRecord::Base

	validates :description, :name, :long, :lat, :address, :start_time, :end_time, :start_date, :end_date, :creator_id, presence: true
	has_many :event_users, dependent: :destroy
	has_many :users, through: :event_users

	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy
end
