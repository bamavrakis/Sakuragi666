FactoryGirl.define do
  factory :private_book, class: "Book" do
    uploader_id 1
    name "Private Book Test"
    author "Private Author"
    private true
    document File.open("app/assets/documents/test.pdf")
    thumbnail File.new("app/assets/documents/test.png")
  end


  factory :public_book, class: "Book" do
    uploader_id 2
    name "Public Book Test"
    author "Public Author"
    private false
    document File.open("app/assets/documents/test.pdf")
    thumbnail File.new("app/assets/documents/test.png")
  end

end
