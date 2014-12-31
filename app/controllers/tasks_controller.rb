class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update_attributes(task_params)
    if @task.save
      redirect_to @task
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
