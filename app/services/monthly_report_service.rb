class MonthlyReportService
  def initialize(month, year)
    @month = month
    @year = year
  end

  def export_to_xlsx_stream
    package = Axlsx::Package.new

    workbook = package.workbook
    workbook.add_worksheet(name: name) do |sheet|

    end

    { read: package.to_stream.read, filename: "#{name}.xlsx" , type: 'application/vnd.ms-excel' }
  end

  private

  def name
    "#{@month}_#{@year}"
  end
end
