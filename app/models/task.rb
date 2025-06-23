class Task < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  belongs_to :assigned_user, class_name: "User", optional: true
end
