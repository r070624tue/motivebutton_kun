class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(date_on: :asc)
  end
end
