class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture

  scope :active, -> { where(deleted_at: nil) }  
  scope :deleted, -> { where.not(deleted_at: nil) }  

  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil) 
  end

  def deleted?
    deleted_at.present?
  end
end
