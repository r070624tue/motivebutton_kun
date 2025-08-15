class Mood < ApplicationRecord
  belongs_to :user

  validates :score, presence: true
  validates :date_on, presence: true

  # validate :only_one_post_per_day, on: :create

  # private

  # def only_one_post_per_day
  #   return unless user.moods.where(date_on: Time.zone.today.all_day).exists?

  #   errors.add(:base, '投稿は1日1回までです')
  # end

  def image_name
    case score
    when 5 then 'yaruki_moeru_man.png'
    when 4 then 'face_smile_woman4.png'
    when 3 then 'face_smile_man1.png'
    when 2 then 'smartphone_gorogoro_woman_neet.png'
    when 1 then 'yaruki_moetsuki_man.png'
    end
  end
end
