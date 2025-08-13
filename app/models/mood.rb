class Mood < ApplicationRecord
  belongs_to :user

  validates :score, presence: true
  validates :date_on, presence: true

  validate :only_one_post_per_day, on: :create

  private

  def only_one_post_per_day
    return unless user.moods.where(date_on: Time.zone.today.all_day).exists?

    errors.add(:base, '投稿は1日1回までです')
  end
end
