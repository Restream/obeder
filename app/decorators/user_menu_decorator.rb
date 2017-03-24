class UserMenuDecorator < Draper::Decorator
  delegate_all

  def print_user_dishes
    model.dishes.order(:name).map(&:name).join(', ')
  end
end
