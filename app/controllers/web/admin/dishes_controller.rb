class Web::Admin::DishesController < Web::Admin::ApplicationController
  def index
    filter = {}

    if !params['type'].nil?
      queried_rec_type = filter[:dish_type_eq] = params['type']
    else
      queried_rec_type = filter[:dish_type_eq] = 'side_dish'
    end

    @data = {
      req_type: queried_rec_type,
      dish_types_labels: {
        side_dish: t('enumerize.dish.dish_types.side_dish'),
        soup: t('enumerize.dish.dish_types.soup'),
        main_dish: t('enumerize.dish.dish_types.main_dish'),
        salad: t('enumerize.dish.dish_types.salad')
      },
      items: Dish.order(:name).ransack(filter).result.page(params[:page])
    }
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
