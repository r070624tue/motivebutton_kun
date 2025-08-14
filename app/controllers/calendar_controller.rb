class CalendarController < ApplicationController
  before_action :authenticate_user!

  def show
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
  end
end
