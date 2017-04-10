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
      "report_#{month}_#{year}.xlsx"
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

    workbook.add_worksheet(name: worksheet_name(@date)) do |sheet|
      last_cell = report_width - 1

      sheet.add_row(report_title, style: workbook_styles[:title])
      sheet.merge_cells(sheet.rows.last.cells[(0..last_cell)])
      sheet.add_row(report_upload_date, style: workbook_styles[:exported])
      sheet.add_row()
      sheet.add_row(report_table_header, style: workbook_styles[:header])

      @users.each do |user|
        user_info_row = report_table_user_info(user)
        user_styles = calendar_styles.map { |style| workbook_styles[style] }
        sheet.add_row(user_info_row, style: user_styles)
      end

      styles = total_styles.map { |style| workbook_styles[style] }
      sheet.add_row(report_table_total, style: styles)
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
      exported: {
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
        bg_color: 'FFFF0000'
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
    I18n.t('report.' + key)
  end

  def month_translate(month_number)
    date = Date.current(month: month_number)
    I18n.l(date, format: :report_month)
  end

  def worksheet_name(date)
    I18n.l(date, format: :report_month_comma_year)
 end

  def date_by_day(date, day)
    date.change(day: day.to_i)
  end

  def all_days_in_month(date)
    (1..Time.days_in_month(date.month, date.year)).to_a.map(&:to_s)
  end

  def report_title
    [I18n.l(@date, format: :report_month_comma_year)]
  end

  def report_upload_date
    [translate('upload_date'), Date.current]
  end

  def report_table_total
    total = []
    total << translate('total')
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
    user_row = []
    user_row << user.name

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

  def calendar_styles
    styles = []
    styles << :name_cell

    daily_styles = all_days_in_month(@date).map do |day|
      date = date_by_day(@date, day)
      if date.saturday? || date.sunday?
        :weekend_cell
      else
        :default_cell
      end
    end

    styles += daily_styles
    styles << :default_cell
  end

  def total_styles
    styles = []
    styles << :total
    all_days_in_month(@date).each { styles << :default_cell }
    styles << :bold_cell
  end

  def report_width
    report_table_header.size
  end
end
