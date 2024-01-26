class User < ApplicationRecord
  has_many :user_courses
  has_many :courses, through: :user_courses

  validates :name, presence: true

  def name_and_email
    "#{name} - #{email} - #{Date.current}"
  end
end
