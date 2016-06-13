require 'will_paginate/array'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_to_library, :readepub]
  before_action :authenticate_user!, :except => :download_book
  has_scope :public_books, :type => :boolean
  layout false, only: [:readepub]

  def index
    @books = Book.public_books.paginate(page: params[:books_page], per_page: 9)
    @my_books = current_user.books.paginate(page: params[:my_books_page], per_page: 9)
    @counter_public = 0
    @counter_private = 0
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
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "in6d6hAzrZR7kHndmbEJlYDj0"
      config.consumer_secret     = "qGu2j1olTgUFj1SOIbeLC8ir6WKQlpFagUiuJHI9nx1k9poAb5"
      config.access_token        = "4120758544-yXuOQj3MoMajzGJBA7MURJYK5batw6pcu6TyqwV"
      config.access_token_secret = "RntyIjCItABYGiBalTBRlLtqnnNGOgFWYvtAre69oLF6H"
    end
    @tweets = @client.search("\"#{@book.name}\"", result_type: "recent").take(5)

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
        if !@book.thumbnail.exists?
          @formato = File.extname(@book.document.path).gsub('.','')
          if @formato == "pdf"
            pdf = Magick::ImageList.new(@book.document.path + "[0]")
            thumb = pdf.scale(340, 440)
            file = Tempfile.new(['processed','.png'])
            thumb.write(file.path)
            @book.thumbnail = file
            @book.save
          end
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


  def rate_book
    @book = Book.find(params[:id])
    if rate_check
      if params[:rating].to_f >=1 && params[:rating].to_f <=5 
        current_user.rate!(@book, params[:rating])
      end
    end
    redirect_to @book
  end

  def rate_check

    if Coletivo::Config.ratings_container.all.select{ |rat|  rat.rateable == @book && rat.person == current_user}.length == 0
      return true
    else
      return false
    end

  end

  def rate_average
    @book = Book.find(params[:id])
    suma = 0
    cantidad = 0 
    Coletivo::Config.ratings_container.all.each do |rating|   
      if rating.rateable == @book 
        suma = suma +rating.weight 
        cantidad = cantidad +1 
      end
    end 
    if cantidad == 0
      return 0
    end
    return suma/cantidad
  end
  helper_method :rate_average

  def recommend
    @book = Book.find(params[:id])
    @words = @book.tags
    @books = Book.all.to_a
    @books.map! do |this_book|
      this_book.define_singleton_method(:jaccard_index) do @jaccard_index;  end

      this_book.define_singleton_method("jaccard_index=") do |index|
        @jaccard_index = index || 0.0
      end

      intersection = (@words & this_book.tags).size
      union = (@words | this_book.tags).size

      this_book.jaccard_index = (intersection.to_f / union.to_f) rescue 0.0
      this_book

    end
    @books.sort_by!{ |book| 1 - book.jaccard_index }
    @books = @books [0..9]
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
      params.require(:book).permit(:name, :author, :popularity, :private, :document, :thumbnail)
    end

    def search_params
      params.require(:book).permit(:name, :author)
    end

end
