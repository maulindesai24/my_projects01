class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :description, presence: true
  belongs_to :assigned_user, class_name: "User", optional: true
  has_many :likes, as: :likeable, dependent: :destroy
end
