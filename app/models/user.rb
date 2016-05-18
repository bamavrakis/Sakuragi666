class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :books
  has_many :uploaded_books, :class_name => 'Book', :foreign_key => 'uploader_id'
  has_attached_file :avatar, styles: { medium: "300x300>", small: "180x180>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
