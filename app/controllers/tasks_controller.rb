class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(date_on: :asc)
  end

  def new
    @task = Task.new
  end

  def create
    tasks = tasks_params.map do |attrs|
      Task.new(
        content: attrs[:content],
        user_id: current_user.id,
        date_on: Date.current,
      )
    end

    if tasks.each(&:save)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
  end

  def edit
    @date  = Date.parse(params[:date])
    @tasks = current_user.tasks.where(date_on: @date).order(:created_at)
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @date = @task.date_on
    if @task.update(task_params)
      redirect_to task_path(@date)
    else
      @tasks = current_user.tasks
                        .where(date_on: @date)
                        .order(:created_at)
      render :show, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :completed)
  end

  def tasks_params
    params.require(:tasks).map { |t| t.permit(:content) }
  end
end
