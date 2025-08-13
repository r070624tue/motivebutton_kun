class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(date_on: :asc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.date_on = Date.current
    @task.status = 0

    if @task.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :date_on, :status).merge(user_id: current_user.id)
  end
end
