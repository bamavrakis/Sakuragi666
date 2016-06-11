include Warden::Test::Helpers
Warden.test_mode!

describe "uploading book process", :type => :feature do

  let(:user) {User.find_by_email("germy@germy.cl")}
  before { login_as(user, scope: :user) }

  it "can upload a book" do
    visit new_book_path
    fill_in "book-name-form", with: "Example book"
    fill_in "book-author-form", with: "Example author"
    check "book-private-form"
    attach_file "book-document-form", "app/assets/documents/test.pdf"
    click_button "New Book"
    expect(page).to have_content "Book was successfully created"
  end

end
