class Book < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  scope :public_books, -> { where(:private => false) }
end
