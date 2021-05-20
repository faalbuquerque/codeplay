class Teacher < ApplicationRecord
  has_one_attached :profile_picture

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
