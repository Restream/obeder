class UserMenuDecorator < Drapper::Decorator
  delegate_all
  decorates_assotiation :menu :dishes

  def get_user_dishes
    model.dishes.order(:name).map(&:name).join(', ')
  end
end
