class ConvertionsController < ApplicationController
  require "open-uri"
  before_action :authenticate_user!
  before_action :set_output_format, only: [:convert]
  before_action :set_book, only: [:convert, :create_preview]
  before_action :set_convertion, only: [:destroy]

  def index
    @ready = current_user.convertions.ready
    @waiting = current_user.convertions.waiting
  end

  def destroy
    @convertion.destroy
    respond_to do |format|
      format.html { redirect_to convertions_url,
                                notice: 'Convertion was successfully' +
                                ' destroyed.' }
      format.json { head :no_content }
    end
  end

  def convert
    @convertion_url = convert_book(@output_format, @book)
    @convertion = Convertion.new(user_id: current_user.id,
                                 convertion_url: @convertion_url,
                                 name: @book.name)
    @convertion.save
    redirect_to @book, notice: 'Book added to your convertions'
  end

  def create_preview
    @convertion_url = convert_book('epub', @book)
    @response = HTTParty.get(@convertion_url)
    while(@response['step'] == 'finished') do
      sleep 1
      @response = HTTParty.get(@convertion_url)
    end
    @book.document = open('http:' + @response['output']['url'])
    @book.save
  end

  def download_convertion
    @convertion = Convertion.find(params[:id])
    @download_link = @convertion.download_link
    @convertion.destroy
    respond_to do |format|
      format.html { redirect_to @download_link }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_convertion
    @convertion = Convertion.find(params[:id])
  end

  def set_output_format
    @output_format = params[:output_format]
  end

  def get_current_format(book)
    File.extname(book.document.path).gsub('.','')
  end

  def create_process_on_cloud_convert(input_format, output_format)
    HTTParty.post('https://api.cloudconvert.com/process',
                  body: {
                    apikey: "mcgo6n6wlB_vfGnPwjiuxkytOtV3PIs3A1MmC-D"+
                      "JescayEgxqKYHu4_HWAfsCqmKssG4hdOO8K4AZnSM51oz8A",
                    inputformat: input_format,
                    outputformat: output_format}.to_json,
                  :headers => {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                  })
  end

  def create_convertion_on_cloud_convert(process, output_format)
    HTTParty.post(process['url'],
                  body: {
                    input: "upload",
                    outputformat: output_format}.to_json,
                  :headers => {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                  })
  end

  def upload_book_to_convertion(convertion, book)
    HTTMultiParty.put(convertion['upload']['url'] + '/' + File.basename(
                        book.document.path),
                      :query => {'file' =>  File.new(book.document.path)})
  end

  def convert_book(output_format, book)
    @current_format = get_current_format(book)
    @cloud_convert_process = create_process_on_cloud_convert(
      @current_format, output_format)
    @cloud_convert_convertion = create_convertion_on_cloud_convert(
      @cloud_convert_process, output_format)
    upload_book_to_convertion(@cloud_convert_convertion, book)
    @cloud_convert_process['url']
  end

  def check_convertions
    current_user.convertions.waiting.each do |c|
      @response = HTTParty.get(c.convertion_url)
      if(@response['step'] == 'finished')
        c.download_link = 'http:' + @response['output']['url']
        c.save
      end
    end
  end

end
