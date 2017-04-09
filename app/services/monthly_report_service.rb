class MonthlyReportService
  def initialize(month, year)
    @month = month.to_i
    @year = year.to_i

    @users = User.order(:name)

    start_date = start_date_by_day(1)
    menus = Menu.in_date_range(start_date, start_date.end_of_month).order(:date)

    @user_menus = UserMenu.joins(:menu).where(menu: menus, neem: false)
      .pluck(:'menus.date', :'user_id')
  end

  def export_to_xlsx_stream
    package = Axlsx::Package.new

    workbook = package.workbook
    workbook.add_worksheet(name: worksheet_name) do |sheet|
      sheet.add_row(report_title)
      sheet.add_row(report_export_date)
      sheet.add_row(report_table_header)
      @users.each do |user|
        sheet.add_row(report_table_user_info(user))
      end
      sheet.add_row(report_table_total)

      #raise sheet.rows.first.cells[].inspect
      last_cell = report_width - 1
      sheet.merge_cells(sheet.rows.first.cells[(0..last_cell)])
      sheet.merge_cells(sheet.rows.second.cells[(0..last_cell)])
      sheet.merge_cells(sheet.rows.last.cells[(0..last_cell)])
    end

    {
      read: package.to_stream.read,
      filename: "report_#{@month}_#{@year}.xlsx" ,
      type: 'application/vnd.ms-excel'
    }
  end

  private

  def translations
    {
      export_date: I18n.t('web.admin.reports.export.export_date'),
      name: I18n.t('web.admin.reports.index.name_column_title'),
      sum: I18n.t('web.admin.reports.index.sum'),
      total: I18n.t('web.admin.reports.index.total'),
      months: (1..12).to_a.map { |month| I18n.t("months_from_digits.#{month}") }
    }
  end

  def start_date_by_day(day)
    "#{day}-#{@month}-#{@year}".to_date
  end

  def all_days_in_month
    (1..Time.days_in_month(@month, @year)).to_a.map(&:to_s)
  end

  def worksheet_name
    "#{translations[:months][@month]} #{@year}"
  end

  def row_wide(row)
    new_row = []
    new_row << row
    (0...report_width - 1).to_a.each { new_row << nil }
    new_row
  end

  def report_title
    row_wide("#{translations[:months][@month]}, #{@year}")
  end

  def report_export_date
    row_wide("#{translations[:export_date]} #{Date.current}")
  end

  def report_table_total
    row_wide("#{translations[:total]} #{@user_menus.size}")
  end

  def report_table_header
    header = []
    header << translations[:name]
    header += all_days_in_month
    header << translations[:sum]
  end

  def report_table_user_info(user)
    user_row = []
    user_row << user.name

    total = 0
    all_days_in_month.each do |day|
      date = start_date_by_day(day)
      if @user_menus.include?([date, user.id])
        user_row << 1
        total += 1
      else
        user_row << nil
      end
    end

    user_row << total
  end

  def report_width
    report_table_header.size
  end
end
