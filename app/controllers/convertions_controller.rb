class ConvertionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ready = []
    @wait = []
    current_user.convertions.each do |c|
      if(!c.download_link)
        @response = HTTParty.get(c.convertion_url)
        if(@response['step'] == 'finished')
          c.download_link = 'http:' + @response['output']['url']
          c.save
          @ready << c
        else
          @wait << c
        end
      else
        @ready << c
      end
    end
  end

  def download_convertion
    @convertion = Convertion.find(params[:id])
    redirect_to @convertion.download_link
  end

  private
end
