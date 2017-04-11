class MonthlyReportService
  def initialize(date)
    @date = date
    @users = User.order(:name)
    menus = Menu.in_date_range(@date.beginning_of_month, @date.end_of_month).order(:date)
    @user_menus = UserMenu.joins(:menu).where(menu: menus, neem: false)
      .pluck(:'menus.date', :'user_id')
  end

  class << self
    def export(month, year)
      date = self.date_from_params(month.to_i, year.to_i)
      instance = self.new(date)
      instance.export_to_xlsx_stream
    end

    def filename(month, year)
      "monthly_report_#{month}_#{year}.xlsx"
    end

    def type
      'application/vnd.ms-excel'
    end

    def date_from_params(month, year)
      "#{1}-#{month}-#{year}".to_date
    end
  end

  def export_to_xlsx_stream
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook_styles = {}
    styles.each { |name, style| workbook_styles[name] = workbook.styles.add_style(style) }

    workbook.add_worksheet(name: month_comma_year(@date)) do |sheet|
      last_cell = report_width - 1

      sheet.add_row(report_title, style: workbook_styles[:title])
      sheet.merge_cells(sheet.rows.last.cells[(0..last_cell)])
      sheet.add_row(report_upload_date, style: workbook_styles[:uploaded])
      sheet.add_row()

      sheet.add_row(report_table_header,
        style: table_header_styles.map { |style| workbook_styles[style] })
      @users.each do |user|
        sheet.add_row(report_table_user_info(user),
          style: table_user_styles.map { |style| workbook_styles[style] })
      end

      sheet.add_row(report_table_total, style: total_styles.map { |style| workbook_styles[style] })

      sheet.column_widths *column_widths
    end

    package.to_stream.read
  end

  private

  def styles
    {
      title: {
        font_name: 'Arial',
        sz: 22,
        b: true,
        alignment: { horizontal: :center }
      },
      uploaded: {
        font_name: 'Arial',
        sz: 9,
        b: false
      },
      header: {
        border: { color: 'FF000000', style: :medium },
        font_name: 'Arial',
        sz: 11,
        b: true,
        alignment: { horizontal: :center }
      },
      header_weekend: {
        border: { color: 'FF000000', style: :medium },
        font_name: 'Arial',
        sz: 11,
        b: true,
        alignment: { horizontal: :center },
        bg_color: '00ea829f'
      },
      name_cell: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: false,
        alignment: { horizontal: :left }
      },
      default_cell: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: false,
        alignment: { horizontal: :center }
      },
      weekend_cell: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: false,
        alignment: { horizontal: :center },
        bg_color: '00ea829f'
      },
      bold_cell: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: true,
        alignment: { horizontal: :center }
      },
      total: {
        border: { color: 'FF000000', style: :thin },
        font_name: 'Arial',
        sz: 11,
        b: true,
        alignment: { horizontal: :right }
      }
    }
  end

  def translate(key)
    I18n.t('monthly_report.' + key)
  end

  def month_translate(month_number)
    date = Date.current(month: month_number)
    I18n.l(date, format: :report_month)
  end

  def date_by_day(date, day)
    date.change(day: day.to_i)
  end

  def all_days_in_month(date)
    (1..Time.days_in_month(date.month, date.year)).to_a.map(&:to_s)
  end

  def month_comma_year(date)
    I18n.t("months_from_digits.#{date.month}") + ', ' + date.year.to_s
  end

  def report_title
    title = [month_comma_year(@date)]
    width = report_width - 1
    width.times { title << nil }
    title
  end

  def report_upload_date
    [translate('upload_date') + ' ' + I18n.l(Date.current, format: :report_default)]
  end

  def report_table_total
    total = [translate('total')]
    width = report_width - 2
    width.times { total << nil }
    total << "#{@user_menus.size}"
  end

  def report_table_header
    header = [translate('name')]
    header += all_days_in_month(@date)
    header << translate('sum')
  end

  def report_table_user_info(user)
    user_row = [user.name]

    total = 0
    all_days_in_month(@date).each do |day|
      date = date_by_day(@date, day)
      if @user_menus.include?([date, user.id])
        user_row << 1
        total += 1
      else
        user_row << nil
      end
    end

    user_row << total
  end

  def calendar_styles(weekend, work)
    all_days_in_month(@date).map do |day|
      date = date_by_day(@date, day)
      if date.saturday? || date.sunday?
        weekend
      else
        work
      end
    end
  end

  def table_header_styles
    styles = [:header]
    styles += calendar_styles(:header_weekend, :header)
    styles << :header
  end

  def table_user_styles
    styles = [:name_cell]
    styles += calendar_styles(:weekend_cell, :default_cell)
    styles << :default_cell
  end

  def total_styles
    styles = [:total]
    all_days_in_month(@date).each { styles << :default_cell }
    styles << :bold_cell
  end

  def report_width
    report_table_header.size
  end

  def column_widths
    col_widths = [40]
    9.times { col_widths << 2 }
    (report_width - 11).times { col_widths << 3 }
    col_widths << 12
  end
end
