module Web::Admin::MonthlyReportsHelper
  def report_header(current_month, current_year)
    [current_month, current_year].join(' ')
  end

  def next_report_params(current_month, current_year)
    next_month = current_month + 1
    next_year = current_year

    if next_month > 12
      next_month = 1
      next_year += 1
    end

    { month: next_month, year: next_year }
  end

  def previous_report_params(current_month, current_year)
    previous_month = current_month - 1
    previous_year = current_year

    if previous_month < 1
      previous_month = 12
      previous_year -= 1
    end

    { month: previous_month, year: previous_year }
  end

  def dates_in_month(beginning_of_month)
    end_of_month = beginning_of_month.end_of_month

    (beginning_of_month..end_of_month).map { |date| date }
  end

  def cell_color_class(date)
    date.saturday? || date.sunday? ? 'danger' : ''
  end

  def user_ate?(user_id, date, user_menus_info)
    user_menus_info.include?([date, user_id])
  end
end
