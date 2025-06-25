class TasksController < ApplicationController
    before_action :set_task, only: [ :show, :destroy, :edit, :update ]

    before_action :authenticate_user!

    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
    end

    def destroy
        if @task.user == current_user
            @task.destroy
            redirect_to admin_tasks_path, notice: "Post deleted."
        else
            redirect_to admin_tasks_path, alert: "Not authorized"
        end
    end

    def edit
    end

    def update
        if @task.assigned_user == current_user || @task.user == current_user
            if @task.update(task_params)
                redirect_to tasks_path, notice: "Task updated."
            else
                render :edit, status: :unprocessable_entity
            end
        else
            redirect_to tasks_path, alert: "You can only update tasks assigned to you."
        end
    end

    private

    def task_params
        params.require(:task).permit(:title, :description, :assigned_user_id, :completed)
    end
    def set_task
        @task = Task.find(params[:id])
    end

    def task_belongs_to_assigned_user?
        @task.assigned_user == current_user
    end
end
