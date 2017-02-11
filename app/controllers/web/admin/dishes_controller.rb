class Web::Admin::DishesController < Web::Admin::ApplicationController
  def index
    @q = Dish.ransack(params[:q])
    @dishes = @q.result.page(params[:page])
  end

  def create
    dish = Dish.new(dish_params)
    if dish.save
      render json: dish
    else
      render json: { errors: dish.errors }
    end
  end

  def update
    dish = Dish.find(params[:id])
    if dish.update(dish_params)
      render json: dish
    else
      render json: { errors: dish.errors }
    end
  end

  def destroy
    dish = Dish.find(params[:id])
    if dish.delete
      render json: dish
    else
      render json: { errors: dish.errors }
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :dish_type)
  end
end
