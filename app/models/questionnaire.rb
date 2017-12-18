class Questionnaire < ApplicationRecord
  validates :body, presence: true
  validate :date_by_check

  belongs_to :user
  has_many :comments

  def date_by_check
    errors.add(:date_by, "には未来の日付を設定してください。") unless
    Time.current < self.date_by
  end
  mount_uploader :qimage, QimageUploader #deviseの設定配下に追記

end
