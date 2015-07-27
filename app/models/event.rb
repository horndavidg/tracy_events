class Event < ActiveRecord::Base

	validates :description, :name, :long, :lat, :time, :address, :duration, :date, :creator_id, presence: true
	has_many :event_users, dependent: :destroy
	has_many :users, through: :event_users

	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy
end
