class MonthlyReportService
  def initialize(month, year)
    @month = month.to_i
    @year = year.to_i
  end

  def export_to_xlsx_stream
    package = Axlsx::Package.new

    workbook = package.workbook
    workbook.add_worksheet(name: name) do |sheet|
      sheet.add_row(xlsx_table_header)
    end

    { read: package.to_stream.read, filename: "#{name}.xlsx" , type: 'application/vnd.ms-excel' }
  end

  private

  def name
    "#{@month}_#{@year}"
  end

  def array_of_days
    (1..Time.days_in_month(@month, @year)).to_a.map(&:to_s)
  end

  def i18n_name_column
    I18n.t('web.admin.reports.index.name_column_title')
  end

  def sum_symb
    '∑'
  end

  def xlsx_table_header
    ([] << i18n_name_column) + array_of_days << sum_symb
  end
end
