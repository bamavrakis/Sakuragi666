require "rails_helper"

RSpec.describe Book, :type => :model do

  it "is valid with a name, private value, file and thumbnail, but no tags" do
    public_book = FactoryGirl.build(:public_book)
    expect(public_book).to be_valid
    private_book = FactoryGirl.build(:private_book)
    expect(private_book).to be_valid
  end

  it "is valid with a name, private value, file, thumbnail and tags" do
    scifi_tag = FactoryGirl.build(:scifi_tag)
    fantasy_tag = FactoryGirl.build(:fantasy_tag)
    tags_list = [scifi_tag,fantasy_tag]
    public_book = FactoryGirl.build(:public_book, tags: tags_list)
    expect(public_book).to be_valid
    private_book = FactoryGirl.build(:private_book)
    expect(private_book).to be_valid
  end

  it "is invalid without a name" do
    book = FactoryGirl.build(:public_book,name: nil)
    book.valid?
    expect(book.errors[:name]).to include("can't be blank")
  end

  it "is public" do
    book = FactoryGirl.build(:public_book)
    expect(book.private).to be_falsy
  end

  it "is private" do
    book = FactoryGirl.build(:private_book)
    expect(book.private).to be_truthy
  end

  it "adds tag" do
    public_book = FactoryGirl.build(:public_book)
    private_book = FactoryGirl.build(:private_book)
    scifi_tag = FactoryGirl.build(:scifi_tag)
    fantasy_tag = FactoryGirl.build(:fantasy_tag)
    public_book.tags << scifi_tag
    private_book.tags << fantasy_tag
    expect(public_book.tags).to eq [scifi_tag]
    expect(private_book.tags).to eq [fantasy_tag]
  end

end
