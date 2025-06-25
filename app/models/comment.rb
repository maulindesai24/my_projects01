class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
end
