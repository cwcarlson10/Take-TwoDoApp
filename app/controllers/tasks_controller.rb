class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tasks = Task.all.order(:is_completed, priority: :asc)
  end

  def show
  end

  def new
    @task = Task.new
    @status = ["Yes", "No"]
    @priority_list = ["1 - High", "1 - Medium", "3 - Low"]
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @priority_list = ["1 - High", "2 - Medium", "3 - Low"]
  end

  def update
    @task.update_attributes(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.delete
    redirect_to tasks_path
  end

  private

    def task_params
      params.require(:task).permit(:title, :category, :priority, :is_completed)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
