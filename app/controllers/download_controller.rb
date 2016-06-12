class DownloadController < ApplicationController
  before_action :set_download_link, only: [:download]
  
  def download
    redirect_to @download_link
  end

  private

  def set_download_link
    @download_link = params[:download_link]

end
