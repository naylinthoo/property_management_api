module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]
      before_action :set_property, only: [:property_tasks]

      def index
        tasks = Task.all
        render json: tasks
      end

      def show
        render json: @task
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task, status: :created
        else
          render json: task.errors, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      def property_tasks
        render json: @property.tasks
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def set_property
        @property = Property.find(params[:property_id])
      end

      def task_params
        params.require(:task).permit(:property_id, :description, :task_type, :assigned_person, :status, :date)
      end
    end
  end
end
