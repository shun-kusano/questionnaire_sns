class Questionnaire < ApplicationRecord
  validates :body, presence: true
  validate :date_by_check
  validate :body_or_image_a
  validate :body_or_image_b

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :answeras, dependent: :destroy
  has_many :answerbs, dependent: :destroy
  has_many :answering_a_users, :through => :answeras, :source => 'user'
  has_many :answering_b_users, :through => :answerbs, :source => 'user'

  has_many :ansnotifications, dependent: :destroy
  has_many :favnotifications, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favored_users, :through => :favorites, :source => 'user'

  def date_by_check
    if date_by.present?
      errors.add(:date_by, "には未来の日付を設定してください。") unless
      Time.current < self.date_by
    end
  end

  def body_or_image_a
    if optiona_body.nil? && optiona_image.nil?
        errors.add("選択肢Aについて、本文か画像のどちらかが必要です。")
    end
  end

  def body_or_image_b
    if optionb_body.nil? && optionb_image.nil?
      errors.add("選択肢Bについて、本文か画像のどちらかが必要です。")
    end
  end

  mount_uploader :qimage, QimageUploader #deviseの設定配下に追記
  mount_uploader :optiona_image, AimageUploader #deviseの設定配下に追記
  mount_uploader :optionb_image, BimageUploader #deviseの設定配下に追記

end
