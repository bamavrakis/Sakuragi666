class Book < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  scope :public, -> { where(:private => false) }
end
