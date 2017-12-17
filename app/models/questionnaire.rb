class Questionnaire < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  validate :date_by_check

    def date_by_check
      binding.pry
      errors.add(:date_by, "には未来の日付を設定してください。") unless
      Time.current < self.date_by
    end
  mount_uploader :qimage, QimageUploader #deviseの設定配下に追記

end
