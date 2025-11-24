class MoodsController < ApplicationController
  def new
    @mood = Mood.new
    @date = parse_date_param || Date.current
  end

  def create
    @date = parse_date_param || Date.current

    @mood = Mood.new(mood_params)
    @mood.date_on = @date

    if @mood.save
      redirect_to new_task_path(date: @date.to_s)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def parse_date_param
    return nil unless params[:date].present?
    Date.parse(params[:date])
  rescue Date::Error
    nil
  end

  def mood_params
    params.require(:mood).permit(:score, :date_on).merge(user_id: current_user.id)
  end
end
