class Web::Admin::MonthlyReportsController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    @date = date
    @users = User.order(:name)
    @menus = Menu.in_date_range(@date.beginning_of_month, @date.end_of_month).order(:date)
    @user_menus = UserMenu.joins(:menu).where(menu: @menus, neem: false)
      .pluck(:'menus.date', :'user_id')
  end

  def export
    send_data(MonthlyReportService.export(date),
      filename: MonthlyReportService.filename(date),
      type: MonthlyReportService.type)
  end

  private

  def date
    Date.parse(params[:date])
  end
end
