class Web::Admin::DishesController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    params[:q] ||= {}
    params[:q][:dish_type_eq] ||= 'soup'

    @q = Dish.order(:name).ransack(params[:q])
    @dishes = @q.result.page(params[:page])
    @selected_dish_type = params[:q][:dish_type_eq]
  end

  def new
    dish_type = params.fetch(:q, {}).fetch(:dish_type_eq, 'soup')
    @dish = Dish.new dish_type: dish_type
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to admin_dishes_path(q: {dish_type_eq: @dish.dish_type})
    else
      render :new
    end
  end

  def update
    @dish = Dish.find(params[:id])

    if @dish.update dish_params
      redirect_to admin_dishes_path(q: {dish_type_eq: @dish.dish_type})
    else
      render :edit
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy

    redirect_to admin_dishes_path(q: {dish_type_eq: @dish.dish_type})
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :dish_type, :image, :image_cache)
  end
end
