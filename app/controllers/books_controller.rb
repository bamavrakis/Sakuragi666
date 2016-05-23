class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  has_scope :public_books, :type => :boolean

  # GET /books
  # GET /books.json
  def index
    @books = Book.public_books.paginate(page: params[:books_page], per_page: 9)
    @my_books = current_user.uploaded_books.paginate(page: params[:my_books_page], per_page: 9)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    #@reader = PDF::Reader.new(open(@book.document.path))
    @formato = File.extname(@book.document.path).gsub('.','')
    if @formato == "mobi"
      Mobi::Metadata.new(File.open(File.expand_path(@book.document.path)))

    elsif @formato == "pdf"
      
      @reader = PDF::Reader.new(open(@book.document.path))
      
    end
    
  end

  # GET /books/new
  def new
    @book = Book.new
    @tags = Tag.all
  end

  # GET /books/1/edit
  def edit
    @tags = Tag.all
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.uploader = current_user
    @formato = File.extname(@book.document.path).gsub('.','')
    if @formato == "pdf"
      pdf = Magick::ImageList.new(@book.document.path)
      thumb = pdf.scale(340, 440)

      @book.thumbnail = File.new(thumb)
    end
    @tags = Tag.find(params[:tags])
    @book.tags = @tags
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
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

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Initial form for searching (we add this so we can make the tag grid).
  def search_form
    @tags = Tag.all
  end

  # Books searching (for now, only by book title).
  def search
    @searched_books = Book.public_books
    if search_params[:name].blank? == false
      @searched_books = @searched_books.where("name like ?", '%' + search_params[:name] + '%')
    end
    if params[:tags]
      @tags = Tag.find(params[:tags])
      @tags.each do |t|
        @searched_books = @searched_books.select { |book| book.tags.include? t}
      end
    end
    @searched_books = @searched_books.paginate(page: params[:search_books_page], per_page: 9)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :popularity, :private, :document)
    end

    def search_params
      params.require(:book).permit(:name)
    end
end
