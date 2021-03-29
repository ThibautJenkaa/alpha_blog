class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :reqire_admin, except: [:index, :show]

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

  def show 

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

  def reqire_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action"
      redirect_to categories_path
    end
  end

end