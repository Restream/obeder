class MenuDecorator < Draper::Decorator
  delegate_all
  decorates_association :menu_dishes
end