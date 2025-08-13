class Mood < ApplicationRecord
  belongs_to :user

  validates :score, presence: true
  validates :date_on, presence: true
end
