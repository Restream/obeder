class DishDecorator < Draper::Decorator
  delegate_all

  def name_with_type
    [model.name, model.dish_type.text].join(' | ')
  end

  def vote_ups_percent
    vote_percent vote_ups_count
  end

  def vote_downs_percent
    vote_percent vote_downs_count
  end

  def vote_percent(vote_count)
    total = vote_ups_count + vote_downs_count
    return 0 if total.zero?

    (100.0 * vote_count) / total
  end
end
