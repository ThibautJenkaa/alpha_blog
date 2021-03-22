class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new 
    @user = User.new
  end

  def show 
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Bienvenue sur Alphablog #{@user.username}";
      redirect_to articles_path
    else
      render @user
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Votre compte a bien été supprimé"
    redirect_to articles_path
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "L'utilisateur à bien été modifié"
      redirect_to articles_path
    else
      render @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "Vous ne pouvez modifier ou effacer que votre profil"
      redirect_to @user
    end
  end

end
