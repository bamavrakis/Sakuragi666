# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
file = File.open("app/assets/documents/test.pdf")
User.create(email: "oscar@oscar.cl", name: "Oscar", last_name: "Estay", kind: "user", password: "password", password_confirmation: "password", avatar: File.new("app/assets/images/bad_joke.png"))
Book.create(user_id: 1, name: "Test 0", private: true, document: file)
Book.create(user_id: 1, name: "Test 1", private: true, document: file)
Book.create(user_id: 1, name: "Test 2", private: true, document: file)
Book.create(user_id: 1, name: "Test 3", private: true, document: file)
Book.create(user_id: 1, name: "Test 4", private: true, document: file)
Book.create(user_id: 1, name: "Test 5", private: true, document: file)
Book.create(user_id: 1, name: "Test 6", private: false, document: file)
Book.create(user_id: 1, name: "Test 7", private: false, document: file)
Book.create(user_id: 1, name: "Test 8", private: false, document: file)
Book.create(user_id: 1, name: "Test 9", private: false, document: file)
Book.create(user_id: 1, name: "Test 10", private: false, document: file)
Book.create(user_id: 1, name: "Test 11", private: true, document: file)
Book.create(user_id: 1, name: "Test 12", private: true, document: file)

file.close
