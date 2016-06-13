# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rmagick'

file = File.open("app/assets/documents/test.pdf")
pdf = Magick::ImageList.new("app/assets/documents/test.pdf")
thumb = pdf.scale(340, 440)
thumb.write "app/assets/documents/test.png"
User.create(email: "oscar@oscar.cl", name: "Oscar", last_name: "Estay", password: "password", password_confirmation: "password", avatar: File.new("app/assets/images/bad_joke.png"), admin: true)
User.create(email: "germy@germy.cl", name: "German", last_name: "Contreras", password: "123456", password_confirmation: "123456", avatar: File.new("app/assets/images/bad_joke.png"), admin: true)
User.create(email: "bastian@bastian.cl", name: "Bastian", last_name: "Mavrakis", password: "lalala", password_confirmation: "lalala", avatar: File.new("app/assets/images/bad_joke.png"), admin: false)

User.create(email: "sakuragi@sakuragi.jp", name: "Hanamichi", last_name: "Sakuragi", password: "haruko", password_confirmation: "haruko", avatar: File.new("app/assets/images/sakuragi.jpg"), admin: false)
User.create(email: "rukawa@rukawa.jp", name: "Kaede", last_name: "Rukawa", password: "sleeping", password_confirmation: "sleeping", avatar: File.new("app/assets/images/rukawa.png"), admin: false)
User.create(email: "akagi@akagi.jp", name: "Takenori", last_name: "Akagi", password: "banana", password_confirmation: "banana", avatar: File.new("app/assets/images/akagi.jpg"), admin: false)
User.create(email: "kogure@kogure.jp", name: "Kiminobu", last_name: "Kogure", password: "glasses", password_confirmation: "glasses", avatar: File.new("app/assets/images/kogure.jpg"), admin: false)
User.create(email: "miyagi@miyagi.jp", name: "Ryota", last_name: "Miyagi", password: "aya-chan", password_confirmation: "aya-chan", avatar: File.new("app/assets/images/miyagi.jpeg"), admin: false)
User.create(email: "haruko@haruko.jp", name: "Haruko", last_name: "Akagi", password: "rukawa", password_confirmation: "rukawa", avatar: File.new("app/assets/images/haruko.jpg"), admin: false)
User.create(email: "ayako@ayako.jp", name: "Ayako", last_name: "Chan", password: "manager", password_confirmation: "manager", avatar: File.new("app/assets/images/ayako.jpg"), admin: false)


@user1 = User.find(1)
@user2 = User.find(2)
@user3 = User.find(3)
@user4 = User.find(4)
@user5 = User.find(5)
@user6 = User.find(6)
@user7 = User.find(7)
@user8 = User.find(8)
@user9 = User.find(9)
@user10 = User.find(10)


Book.create(uploader_id: 1, name: "Moby Dick", author: "Herman Melville", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Frankenstein", author: "Mary Wollstonecraft Shelley", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 2, name: "Ender's Game", author: "Orson Scott Card", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 2, name: "Speaker for the Dead", author: "Orson Scott Card", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 3, name: "The Metamorphosis", author: "Franz Kafka", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 3, name: "The Name of the Wind", author: "Patrick Rothfuss", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 4, name: "The Stranger", author: "Albert Camus", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 4, name: "The Wise Man's Fear", author: "Patrick Rothfuss", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 5, name: "One Piece Volume 1", author: "Eiichiro Oda", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 5, name: "A Game of Thrones", author: "George R. R. Martin", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 6, name: "Steppenwolf", author: "Herman Hesse", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 6, name: "A Clash of Kings", author: "George R. R. Martin", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 7, name: "Siddhartha", author: "Herman Hesse", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 7, name: "A Storm of Swords", author: "George R. R. Martin", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 8, name: "Demian", author: "Herman Hesse", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 8, name: "A Feast for Crows", author: "George R. R. Martin", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 9, name: "Brave New World", author: "Aldous Huxley", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 9, name: "A Dance with Dragons", author: "George R. R. Martin", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 10, name: "Animal Farm", author: "George Orwell", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 10, name: "1984", author: "George Orwell", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))


Tag.create(name:"Science Fiction")
Tag.create(name:"Fantasy")
Tag.create(name:"Satire")
Tag.create(name:"Drama")
Tag.create(name:"Action & Adventure")
Tag.create(name:"Romance")
Tag.create(name:"Mystery")
Tag.create(name:"Horror")
Tag.create(name:"Self Help & Health")
Tag.create(name:"Guide & Travel")
Tag.create(name:"Children")
Tag.create(name:"Religion")
Tag.create(name:"Math & Science")
Tag.create(name:"History")
Tag.create(name:"Poetry & Art")
Tag.create(name:"Encyclopedias")
Tag.create(name:"Dictionaries")
Tag.create(name:"Comics")
Tag.create(name:"Cookbooks")
Tag.create(name:"Diaries & Journals")
Tag.create(name:"Biographies")

# Add three random tags per book
@books = Book.all
@tags = Tag.all

@books1 = @books.where('uploader_id = 1')
@books1.each do |book|
  @user1.books << book
end

@books2 = @books.where('uploader_id = 2')
@books2.each do |book|
  @user2.books << book
end

@books3 = @books.where('uploader_id = 3')
@books3.each do |book|
  @user3.books << book
end

@books4 = @books.where('uploader_id = 4')
@books4.each do |book|
  @user4.books << book
end

@books5 = @books.where('uploader_id = 5')
@books5.each do |book|
  @user5.books << book
end

@books6 = @books.where('uploader_id = 6')
@books6.each do |book|
  @user6.books << book
end

@books7 = @books.where('uploader_id = 7')
@books7.each do |book|
  @user7.books << book
end

@books8 = @books.where('uploader_id = 8')
@books8.each do |book|
  @user8.books << book
end

@books9 = @books.where('uploader_id = 9')
@books9.each do |book|
  @user9.books << book
end

@books10 = @books.where('uploader_id = 10')
@books10.each do |book|
  @user10.books << book
end

@user1.books.each do |book|
  book.tags = @tags.sample(3)
end

@user2.books.each do |book|
  book.tags = @tags.sample(3)
end

@user3.books.each do |book|
  book.tags = @tags.sample(3)
end
<<<<<<< HEAD

@user4.books.each do |book|
  book.tags = @tags.sample(3)
end

@user5.books.each do |book|
  book.tags = @tags.sample(3)
end

@user6.books.each do |book|
  book.tags = @tags.sample(3)
end

@user7.books.each do |book|
  book.tags = @tags.sample(3)
end

@user8.books.each do |book|
  book.tags = @tags.sample(3)
end

@user9.books.each do |book|
  book.tags = @tags.sample(3)
end

@user10.books.each do |book|
  book.tags = @tags.sample(3)
end

Book.all.each do |libro|
	@user1.rate!(libro,Random.new.rand(1..4))
	@user2.rate!(libro,Random.new.rand(1..4))
	@user3.rate!(libro,Random.new.rand(1..4))
	@user4.rate!(libro,Random.new.rand(1..4))
	@user5.rate!(libro,Random.new.rand(1..4))
	@user6.rate!(libro,Random.new.rand(1..4))
	@user7.rate!(libro,Random.new.rand(1..4))
	@user8.rate!(libro,Random.new.rand(1..4))
	@user9.rate!(libro,Random.new.rand(1..4))
	@user10.rate!(libro,Random.new.rand(1..4))

end
file.close
