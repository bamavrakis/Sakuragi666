class Convertion < ActiveRecord::Base
  belongs_to :user

  scope :waiting, -> { where(download_link: nil) }
  scope :ready, -> { where.not(download_link: nil) }
end
