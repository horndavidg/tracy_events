class Photo < ActiveRecord::Base
	validates :creator_id, :url, presence: true
	belongs_to :event
end
