class Comment < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :haunt, optional: true

	validates :content, presence: true
end
