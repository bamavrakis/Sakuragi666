FactoryGirl.define do

  factory :user, class: "User" do
    email "example@example.com"
    name "Mr. Exam"
    last_name "Ples"
    kind "user"
    password "example"
    password_confirmation "example"
    avatar File.new("app/assets/images/bad_joke.png")
  end

end
