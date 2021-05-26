class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :duration, presence: true
  validates :content, presence: true
end
