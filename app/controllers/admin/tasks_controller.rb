class Admin::TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :check_admin

    def index
        @tasks = Task.all
    end

    def check_admin
        redirect_to root_path, alert: "Not authorized!" unless current_user.admin?
    end

    def new 
        @task = Task.new
    end

    def create 
        @task = Task.new(task_params)
        @task.user = current_user 
        if @task.save
            redirect_to admin_tasks_path notice: "Post created successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        #@task = Task.find(params[:id])
    end

    def edit
        redirect_to admin_tasks_path, alert: "Not authorized" unless @task.user == current_user
    end

    def update
        if @task.user == current_user
            if @task.update(task_params)
                redirect_to admin_tasks_path, notice: "Task updated."
            else
                render :edit, status: :unprocessable_entity
            end
        else
            redirect_to admin_tasks_path, alert: "Not authorized"
        end
    end

    def destroy
        if @task.user == current_user
            @task.destroy
            redirect_to admin_tasks_path, notice: "Post deleted."
        else
            redirect_to admin_tasks_path, alert: "Not authorized"
        end
    end

    private

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:title, :description, :assigned_user_id)
    end
end
