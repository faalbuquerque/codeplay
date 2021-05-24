class Teacher < ApplicationRecord
  has_one_attached :profile_picture
  has_many :courses

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
