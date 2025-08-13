class MoodsController < ApplicationController
  def new
    @mood = Mood.new
  end

  def create
    Mood.create(mood_params)
    redirect_to '/'
  end

  private

  def mood_params
    params.require(:mood).permit(:score, :date_on).merge(user_id: current_user.id)
  end
end
