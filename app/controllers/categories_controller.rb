class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "La catégorie à bien été créée"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit 

  end

  def update 
    if @category.update(category_params)
      flash[:notice] = "Le nom de la catégorie a bien été modifié"
      redirect_to @category
    else 
      render 'edit'
    end
  end

  def show 
    @articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action"
      redirect_to categories_path
    end
  end

end