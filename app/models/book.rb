class Book < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User'
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  scope :public_books, -> { where(:private => false) }
  validates_presence_of :name
  has_attached_file :document#, :styles => { :pdf_thumbnail => ["", :jpg] }, :processors => [:pdf_thumbnail]
  validates_attachment_content_type :document, :content_type => ["application/pdf","application/epub+zip","application/vnd.amazon.ebook"], :size => { :in => 0..350.megabytes }
  has_attached_file :thumbnail, styles: { medium: "340x440>", small: "170x220>", thumb: "85x110>" }, default_url: ":style/missing_thumbnail.png"
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\Z/
end
