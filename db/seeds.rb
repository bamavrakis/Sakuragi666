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
User.create(email: "oscar@oscar.cl", name: "Oscar", last_name: "Estay", kind: "user", password: "password", password_confirmation: "password", avatar: File.new("app/assets/images/bad_joke.png"))
Book.create(uploader_id: 1, name: "Test 0", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 1", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 2", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 3", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 4", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 5", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 6", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 7", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 8", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 9", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 10", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 11", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 12", private: false, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 13", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 14", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 15", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 16", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))
Book.create(uploader_id: 1, name: "Test 17", private: true, document: file, thumbnail: File.new("app/assets/documents/test.png"))

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

file.close
