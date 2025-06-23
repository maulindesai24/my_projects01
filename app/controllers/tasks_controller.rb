class TasksController < ApplicationController
    before_action :set_task, only: [:show, :destroy]

    before_action :authenticate_user!

    def index
        @tasks = Task.all
    end

    def show
        @task = current_user.tasks.find(params[:id])
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

end
