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
        status: 0
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

  private

  def tasks_params
    params.require(:tasks).map { |t| t.permit(:content) }
  end
end
