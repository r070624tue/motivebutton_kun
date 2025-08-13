class MoodsController < ApplicationController
  def new
    @mood = Mood.new
  end

  def create
    @mood = current_user.moods.build(mood_params)
    @mood.date_on ||= Date.current

    if @mood.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def mood_params
    params.require(:mood).permit(:score, :date_on).merge(user_id: current_user.id)
  end
end
