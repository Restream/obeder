class MenuDecorator < Draper::Decorator
  delegate_all
  decorates_association :menu_dishes

  def self.collection_decorator_class
    ClosestDaysMenusDecorator
  end
end