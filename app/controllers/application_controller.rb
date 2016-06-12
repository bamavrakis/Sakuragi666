class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :banned?
  before_filter :check_convertions
  
  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been suspended."
      root_path
    end
  end

  def check_convertions
    if current_user.present?
      current_user.convertions.waiting.each do |c|
        @response = HTTParty.get(c.convertion_url)
        if(@response['step'] == 'finished')
          c.update(download_link: 'http:' + @response['output']['url'])
        end
      end
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
