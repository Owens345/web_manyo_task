class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.latest

    if params[:sort_deadline_on]
      @tasks = current_user.tasks.sort_deadline
    elsif params[:sort_priority]
      @tasks = current_user.tasks.sort_priority
    end

    if params[:search].present?
      title = params[:search][:title]
      status = params[:search][:status]

      if title.present? && status.present?
        @tasks = @tasks.search_title(title).search_status(status)
      elsif title.present?
        @tasks = @tasks.search_title(title)
      elsif status.present?
        @tasks = @tasks.search_status(status)
      end
    end

    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: t('tasks.flash.created')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('tasks.flash.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('tasks.flash.destroyed')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status)
  end

  def correct_user
    unless @task.user == current_user
      flash[:alert] = 'You do not have permission to access'
      redirect_to tasks_path
    end
  end
end