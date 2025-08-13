class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(date_on: :asc)
  end

  def new
    @task = Task.new
  end
end
