class Course < ApplicationRecord
  belongs_to :teacher
  has_many :lessons, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :price, presence: true
end
