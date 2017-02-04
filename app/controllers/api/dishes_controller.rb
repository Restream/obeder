class Api::DishesController < Api::ApplicationController
  def index
    dishes = Dish.all
    render json: dishes
  end

  def create
    dish = Dish.new(marker_params)
    if dish.save
      render json: dish
    else
      render json: { errors: dish.errors }
    end
  end

  def update
    dish = Dish.find(params[:id])
    if dish.update(marker_params)
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

  def marker_params
    params.require(:dish).permit(:name, :description, :dish_type)
  end
end
