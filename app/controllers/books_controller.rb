require 'will_paginate/array'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_to_library, :convert, :readepub]
  before_action :set_output_format, only: [:convert]
  before_action :authenticate_user!
  has_scope :public_books, :type => :boolean
  layout false, only: [:readepub]

  def index
    @books = Book.public_books.paginate(page: params[:books_page], per_page: 9)
    @my_books = current_user.books.paginate(page: params[:my_books_page], per_page: 9)
  end

  def show
    @formato = File.extname(@book.document.path).gsub('.','')
    @supported_files = ['epub', 'mobi', 'azw3', 'pdf']
    @supported_files.delete(File.extname(@book.document.path).gsub('.',''))
    if @formato == "mobi"
      Mobi::Metadata.new(File.open(File.expand_path(@book.document.path)))
    elsif @formato == "pdf"
      @reader = PDF::Reader.new(open(@book.document.path))
    end
  end

  def new
    @book = Book.new
    @tags = Tag.all
  end

  def readepub
  end

  def edit
    @tags = Tag.all
  end

  def create
    @book = Book.new(book_params)
    @book.uploader = current_user
    if params[:tags]
      @tags = Tag.find(params[:tags])
      @book.tags = @tags
    else
      @book.tags = []
    end
    respond_to do |format|
      if @book.save
        @formato = File.extname(@book.document.path).gsub('.','')
        if @formato == "pdf"
          pdf = Magick::ImageList.new(@book.document.path)
          thumb = pdf.scale(340, 440)
          file = Tempfile.new(['processed','.png'])
          thumb.write(file.path)
          @book.thumbnail = file
          @book.save
        end
        current_user.books << @book
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        @tags = Tag.find(params[:tags])
        @book.tags = @tags
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_library
    current_user.books << @book
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Book was successfully added to your library.' }
      format.json { render :show, status: :ok, location: @book }
    end
  end

  # def convert
  #   @current_format = File.extname(@book.document.path).gsub('.','')
  #   @response = HTTParty.post('https://api.cloudconvert.com/process',
  #   body: {
  #     apikey: "mcgo6n6wlB_vfGnPwjiuxkytOtV3PIs3A1MmC-DJescayEgxqKYHu4_HWAfsCqmKssG4hdOO8K4AZnSM51oz8A",
  #     inputformat: @current_format,
  #     outputformat: @output_format}.to_json,
  #   :headers => {
  #       'Content-Type' => 'application/json',
  #       'Accept' => 'application/json'
  #   })
  #   @upload = HTTParty.post(@response['url'],
  #   body: {
  #   input: "upload",
  #   outputformat: @output_format,
  #   save: true}.to_json,
  #   :headers => {
  #       'Content-Type' => 'application/json',
  #       'Accept' => 'application/json'
  #   })
  #   HTTMultiParty.put(@upload['upload']['url'] + '/' + File.basename(@book.document.path), :query => {
  #     'file' =>  File.new(@book.document.path)})
  #   @conversion = Convertion.new(user_id: current_user.id, convertion_url: @response['url'], name: @book.name)
  #   @conversion.save
  #   redirect_to @book, notice: 'Book added to your conversions'
  # end

  def convert
    @current_format = File.extname(@book.document.path).gsub('.','')
    @response = HTTParty.post('https://api.cloudconvert.com/process',
    body: {
      apikey: "mcgo6n6wlB_vfGnPwjiuxkytOtV3PIs3A1MmC-DJescayEgxqKYHu4_HWAfsCqmKssG4hdOO8K4AZnSM51oz8A",
      inputformat: @current_format,
      outputformat: @output_format}.to_json,
    :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
    })
    @upload = HTTParty.post(@response['url'],
    body: {
    input: "download",
    file: @book.document.path,
    outputformat: @output_format,
    save: true}.to_json,
    :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
    })
    @conversion = Convertion.new(user_id: current_user.id, convertion_url: @response['url'], name: @book.name)
    @conversion.save
    redirect_to @book, notice: 'Book added to your conversions'
  end

  # Initial form for searching (we add this so we can make the tag grid).
  def search_form
    @tags = Tag.all
  end

  # Books searching.
  def search
    @searched_books = Book.public_books
    if search_params[:name].blank? == false
      @searched_books = @searched_books.where("name like ?", '%' + search_params[:name] + '%')
    end
    if search_params[:author].blank? == false
      @searched_books = @searched_books.where("author like ?", '%' + search_params[:author] + '%')
    end
    if params[:tags]
      @tags = Tag.find(params[:tags])
      @tags.each do |t|
        @searched_books = @searched_books.select { |book| book.tags.include? t}
      end
    end
    @searched_books = @searched_books.paginate(page: params[:search_books_page], per_page: 9)
  end

  def send_form
    @book = Book.find(params[:id])
  end

  def send_book
    @book = Book.find(params[:id])
    size = @book.document.size
    email = params[:email]
    message = params[:message]
    if size < 25000000
      BookMailer.send_small_book(email,current_user,@book,message).deliver_now
    else
      BookMailer.send_big_book(email,current_user,@book,message).deliver_now
    end
    redirect_to @book, notice: 'Book sent successfully'
  end

  def download_book
    @book = Book.find(params[:id])
    @formato = File.extname(@book.document.path).gsub('.','')
    book_name = @book.name.gsub(' ','-').downcase + '.' + @formato
    if @formato == "pdf"
      send_file @book.document.path, :type => 'application/pdf', :filename => book_name
    elsif @formato == "epub"
      send_file @book.document.path, :type => 'application/epub+zip', :filename => book_name
    else
      send_file @book.document.path, :type => 'application/vnd.amazon.ebook', :filename => book_name
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :popularity, :private, :document)
    end

    def search_params
      params.require(:book).permit(:name, :author)
    end

    def set_output_format
      @output_format = params[:output_format]
    end

end
