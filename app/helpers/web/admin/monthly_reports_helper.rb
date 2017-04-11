module Web::Admin::MonthlyReportsHelper
  def report_header(date)
    I18n.l(date, format: :report_month_comma_year)
  end

  def next_report_params(date)
    date.next_month
  end

  def previous_report_params(date)
    date.prev_month
  end

  def dates_in_month(date)
    (date.beginning_of_month..date.end_of_month).to_a
  end

  def cell_color_class(date)
    date.saturday? || date.sunday? ? 'danger' : ''
  end

  def user_ate?(user_id, date, user_menus_info)
    user_menus_info.include?([date, user_id])
  end
end
