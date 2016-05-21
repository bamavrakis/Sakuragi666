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

    @file = Rails.public_path + @book.document.path

    #@client = CloudConvert::Client.new(api_key: "RpZNlEckdEIJWv3GG0z4pX1BdqvJV1Lp1DzzZdvABlsmpXrjR0rqpb36-gNWDcm3nSTwY2tObtb6GoMZnBuX9A")
    #@process = @client.build_process(input_format: :pdf, output_format: :pdf)
    #@process_response = @process.create
    #@conversion_response = @process.convert(
    #    input: "upload",
    #    outputformat: :pdf,
    #    file: @file,
    #    download: "false"
    #)




    


    #sleep 10

    #path = File.join(File.dirname(__FILE__), "output")
    #@download = @process.download_url
    #@converted = RGhost::Convert.new(@book.document.path).to :azw
    #File.open(@converted, 'rb') do |f|
    #send_data f.read


  


  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.uploader = current_user
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :popularity, :private, :document)
    end

end
