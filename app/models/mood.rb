class Mood < ApplicationRecord
  belongs_to :user

  validates :score, presence: true
  validates :date_on, presence: true

  validate :only_one_post_per_day, on: :create

  def image_name
    case score
    when 5 then 'yaruki_moeru_man.png'
    when 4 then 'face_smile_woman4.png'
    when 3 then 'face_smile_man1.png'
    when 2 then 'smartphone_gorogoro_woman_neet.png'
    when 1 then 'yaruki_moetsuki_man.png'
    end
  end

  def mood_name
    case score
    when 5 then 'やる気満々（最高）'
    when 4 then '良好'
    when 3 then '普通'
    when 2 then 'やや低調'
    when 1 then 'やる気なし（最悪）'
    else '不明'
    end
  end

  private

  def only_one_post_per_day
    return unless date_on.present?
    return unless user.moods.where(date_on: date_on).exists?

    errors.add(:base, "#{l(date_on, format: :long)}の気分は既に登録されています")
  end
end
