class Web::Admin::DishesController < Web::Admin::ApplicationController
  def index
    @q = Dish.order(:name).ransack(params[:q])
    @dishes = @q.result.page(params[:page])
  end

  def new
    @dish = Dish.new
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to admin_dishes_path
    else
      render :new
    end
  end

  def update
    @dish = Dish.find(params[:id])

    if @dish.update dish_params
      redirect_to admin_dishes_path
    else
      render :edit
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy

    redirect_to admin_dishes_path
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :dish_type)
  end
end
