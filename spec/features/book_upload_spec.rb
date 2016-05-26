include Warden::Test::Helpers
Warden.test_mode!

describe "uploading book process", :type => :feature do

  let(:user) {FactoryGirl.create(:user)}
  before { login_as(user, scope: :user) }

  it "can upload a book" do
    visit new_book_path
    fill_in "book-name-form", with: "Example book"
    check "book-private-form"
    attach_file "book-document-form", "app/assets/documents/test.pdf"
    click_button "New Book"
    expect(page).to have_content "Success"
  end

end
