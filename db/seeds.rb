# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rmagick'

#file = File.open("app/assets/documents/test.pdf")
#pdf = Magick::ImageList.new("app/assets/documents/test.pdf")
#thumb = pdf.scale(340, 440)
#thumb.write "app/assets/documents/test.png"
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


Book.create(uploader_id: 1, name: "Moby Dick", author: "Herman Melville", private: true, document: File.open("app/assets/documents/books/mobydick.epub"), thumbnail: File.new("app/assets/documents/thumbnails/mobydick.png"))
Book.create(uploader_id: 1, name: "Grimms' Fairy Tales", author: "Jacob Grimm and Wilhelm Grimm", private: false, document: File.open("app/assets/documents/books/grimmfairytales.pdf"), thumbnail: File.new("app/assets/documents/thumbnails/grimmfairytales.png"))
Book.create(uploader_id: 2, name: "Ulysses", author: "James Joyce", private: true, document: File.open("app/assets/documents/books/ulysses.epub"), thumbnail: File.new("app/assets/documents/thumbnails/ulysses.jpg"))
Book.create(uploader_id: 2, name: "The Practice and Science of Drawing", author: "Harold Speed", private: false, document: File.open("app/assets/documents/books/drawing.epub"), thumbnail: File.new("app/assets/documents/thumbnails/drawing.jpg"))
Book.create(uploader_id: 3, name: "The Metamorphosis", author: "Franz Kafka", private: true, document: File.open("app/assets/documents/books/metamorphosis.epub"), thumbnail: File.new("app/assets/documents/thumbnails/metamorphosis.jpg"))
Book.create(uploader_id: 3, name: "Calculus Made Easy", author: "Silvanus P. Thompson", private: false, document: File.open("app/assets/documents/books/calculus.pdf"), thumbnail: File.new("app/assets/documents/thumbnails/calculus.jpg"))
Book.create(uploader_id: 4, name: "Adventures of Huckleberry Finn", author: "Mark Twain", private: true, document: File.open("app/assets/documents/books/huckleberry.epub"), thumbnail: File.new("app/assets/documents/thumbnails/huckleberry.jpg"))
Book.create(uploader_id: 4, name: "Alice's Adventures in Wonderland", author: "Lewis Carroll", private: false, document: File.open("app/assets/documents/books/alice.pdf"), thumbnail: File.new("app/assets/documents/thumbnails/alice.jpg"))
Book.create(uploader_id: 5, name: "The Strange Case of Dr. Jekyll and Mr. Hyde", author: "Robert Louis Stevenson", private: true, document: File.open("app/assets/documents/books/jekyll.epub"), thumbnail: File.new("app/assets/documents/thumbnails/jekyll.jpg"))
Book.create(uploader_id: 5, name: "Pride and Prejudice", author: "Jane Austen", private: false, document: File.open("app/assets/documents/books/prideprejudice.pdf"), thumbnail: File.new("app/assets/documents/thumbnails/prideprejudice.jpg"))
Book.create(uploader_id: 6, name: "Don Quixote", author: "Miguel de Cervantes Saavedra", private: true, document: File.open("app/assets/documents/books/quixote.epub"), thumbnail: File.new("app/assets/documents/thumbnails/quixote.jpg"))
Book.create(uploader_id: 6, name: "Les Misérables", author: "Víctor Hugo", private: false, document: File.open("app/assets/documents/books/lesmiserables.epub"), thumbnail: File.new("app/assets/documents/thumbnails/lesmiserables.jpg"))
Book.create(uploader_id: 7, name: "Siddhartha", author: "Herman Hesse", private: true, document: File.open("app/assets/documents/books/siddhartha.epub"), thumbnail: File.new("app/assets/documents/thumbnails/siddhartha.jpg"))
Book.create(uploader_id: 7, name: "The Life and Adventures of Robinson Crusoe", author: "Daniel Defoe", private: false, document: File.open("app/assets/documents/books/crusoe.epub"), thumbnail: File.new("app/assets/documents/thumbnails/crusoe.jpg"))
Book.create(uploader_id: 8, name: "The War of the Worlds", author: "H. G. Wells", private: true, document: File.open("app/assets/documents/books/warofworlds.epub"), thumbnail: File.new("app/assets/documents/thumbnails/warworlds.jpg"))
Book.create(uploader_id: 8, name: "The Adventures of Sherlock Holmes", author: "Arthur Conan Doyle", private: false, document: File.open("app/assets/documents/books/sherlock.epub"), thumbnail: File.new("app/assets/documents/thumbnails/sherlock.jpg"))
Book.create(uploader_id: 9, name: "Peter Pan", author: "J. M. Barrie", private: true, document: File.open("app/assets/documents/books/peterpan.epub"), thumbnail: File.new("app/assets/documents/thumbnails/peterpan.jpg"))
Book.create(uploader_id: 9, name: "The Waste Land", author: "T. S. Eliot", private: false, document: File.open("app/assets/documents/books/wasteland.epub"), thumbnail: File.new("app/assets/documents/thumbnails/wasteland.jpg"))
Book.create(uploader_id: 10, name: "War and Peace", author: "Leo Tolstoy", private: true, document: File.open("app/assets/documents/books/warpeace.epub"), thumbnail: File.new("app/assets/documents/thumbnails/warpeace.jpg"))
Book.create(uploader_id: 10, name: "Adventures of Tom Sawyer", author: "Mark Twain", private: false, document: File.open("app/assets/documents/books/tomsawyer.epub"), thumbnail: File.new("app/assets/documents/thumbnails/tomsawyer.jpg"))


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
@users = User.all

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
  User.all.each do |user|
    if Random.new.rand(0..1) == 1
  	 user.rate!(libro,Random.new.rand(1..5))
    end

  end

end

#file.close
