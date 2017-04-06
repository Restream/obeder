class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    @menus = monthly_report_menus
    @user_menus = UserMenu.where(menu: @menus).includes(:user)
  end

  def export

  end

  private

  def monthly_report_menus
    Menu.in_date_range(start_date, end_date)
  end

  def start_date
    "01-#{month}-#{year}".to_date
  end

  def end_date
    start_date + 1.month - 1.day
  end

  def year
    params[:year].to_i
  end

  def month
    params[:month].to_i
  end
end
