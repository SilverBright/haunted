class Haunt < ApplicationRecord
	belongs_to :user, optional: true
	has_many :comments
	has_many :users, through: :comments

	validates :name, uniqueness: true

	accepts_nested_attributes_for :comments
end
