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

  def recommend
    #preferences = {}
    #preferences_current = {}
    #User.all.each do |user|
    #  if user.email!= "oscar@oscar.cl"
    #    preference = {}
    #    pref = Coletivo::Config.ratings_container.select {|rating| user.id == rating.person_id}
    #    pref.each do |prefe|
    #      preference.merge!({prefe.rateable_id.to_s => prefe.weight.to_f})
    #    end
    #    preferences.merge!({user.email => preference})
    #  end

    #end
    #preference = {}
    #pref = Coletivo::Config.ratings_container.select {|rating| 1 == rating.person_id}
    #  pref.each do |prefe|
    #    preference.merge! ({prefe.rateable_id.to_s => prefe.weight.to_f})
    #  end
    #preferences_current.merge!({"oscar@oscar.cl" => preference})


    #recommender = Recommendation::Recommender.new(preferences)
    #recommender.train(preferences_current)
    @recommended = Book.find_recommendations_for(current_user, :strategy => :pearson)
    #recommended1 = Recommendation::Recommender.recommendation(recommender.table, current_user.email)
    #@recommended = Books.all.select {|book| }


    
  end


end




