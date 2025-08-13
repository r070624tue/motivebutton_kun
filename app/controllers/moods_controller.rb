class MoodsController < ApplicationController
  def new
    @mood = Mood.new
  end
end
