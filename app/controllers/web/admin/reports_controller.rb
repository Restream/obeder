class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    @beginning_of_month = start_date
    @report_year = year.to_i
    @report_month = month.to_i
    @users = User.order(:name)
    @menus = monthly_report_menus
    @user_menus = UserMenu.joins(:menu).where(menu: @menus, neem: false)
      .pluck(:'menus.date', :'user_id')
  end

  def export

  end

  private

  def monthly_report_menus
    Menu.in_date_range(start_date, start_date.end_of_month).order(:date)
  end

  def start_date
    "01-#{month}-#{year}".to_date
  end

  def year
    params[:year]
  end

  def month
    params[:month]
  end
end
