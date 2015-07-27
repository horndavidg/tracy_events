class Comment < ActiveRecord::Base
	validates :content, :creator_id, presence: true
	belongs_to :event
end
