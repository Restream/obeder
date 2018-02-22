class DishDecorator < Draper::Decorator
  delegate_all

  def name_with_type
    [model.name, model.dish_type.text].join(' | ')
  end

  def vote_ups_percent
    total = vote_ups_count + vote_downs_count
    return 0 if total.zero?
    (100.0 * vote_ups_count) / total
  end

  def vote_downs_percent
    total = vote_ups_count + vote_downs_count
    return 0 if total.zero?
    (100.0 * vote_downs_count) / total
  end
end
