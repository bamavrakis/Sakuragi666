class Book < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  scope :public_books, -> { where(:private => false) }
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => "application/pdf", :size => { :in => 0..350.megabytes }
end
