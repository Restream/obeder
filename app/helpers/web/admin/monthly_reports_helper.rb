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

  def report_row(user, user_index, dates, user_menus)
    total_by_user = 0

    name_cell = content_tag(:td) do
      [user_index + 1, user.name].join('. ')
    end

    dates_collection = dates.collect do |date|
      if user_ate?(user.id, date, user_menus)
        total_by_user += 1
        content_tag :td, 1, class: cell_color_class(date)
      else
        content_tag :td, '', class: cell_color_class(date)
      end
    end

    dates_cells = dates_collection.join().html_safe

    total_cell = content_tag :td, total_by_user
    content_tag :tr, name_cell.concat(dates_cells).concat(total_cell), class: 'text-center'
  end
end
