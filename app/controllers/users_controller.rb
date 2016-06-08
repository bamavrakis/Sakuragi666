class UsersController < ApplicationController
  def index
    authorize! :index, User
    @users = User.order('id DESC').all.paginate(
      page: params[:users_page], per_page: 20)
  end
  def ban 
    authorize! :ban, User
    @user = User.find(params[:id])
    @user.update(banned: true)
    respond_to do |format|
      format.html { redirect_to users_url,
                                notice: 'User was successfully banned' }
      format.json { head :no_content }
    end
  end
  def unban 
    authorize! :unban, User
    @user = User.find(params[:id])
    @user.update(banned: false)
    respond_to do |format|
      format.html { redirect_to users_url,
                                notice: 'User was successfully unbanned' }
      format.json { head :no_content }
    end
  end

#Upgrades a normal user to admin
  def upgrade
    authorize! :upgrade, User
    @user = User.find(params[:id])
    @user.update(admin: true)
    respond_to do |format|
      format.html { redirect_to users_url,
                                notice: 'User was successfully upgraded' }
      format.json { head :no_content }
      end
  end

#Downgrades an admin to a normal user
  def downgrade
    authorize! :downgrade, User
    @user = User.find(params[:id])
    @user.update(admin: false)
    respond_to do |format|
      format.html { redirect_to users_url,
                                notice: 'User was successfully downgraded' }
      format.json { head :no_content }
    end
  end

end
