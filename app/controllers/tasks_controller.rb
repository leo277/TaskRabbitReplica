class TasksController < ApplicationController

	before_action :find_task, only: [:update, :edit, :show, :destroy]

	def index
		if(!params[:category_id].blank?)
			category_id = Category.find_by_id(params[:category_id])
			@tasks = Task.where(:category_id => category_id).order("created_at DESC")
		else
			@tasks = Task.all.order("created_at DESC")
		end
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(tasks_params)

			if @task.save
				redirect_to @task
			else
				render :new
			end
	end

	def update
		if @task.update_attributes(tasks_params)
			redirect_to @task
		else
			render :edit
		end
	end

	def edit
	end

	def show
	end

	def destroy
		@task.destroy
		redirect_to root_path
	end

	private

	def tasks_params
		params.require(:task).permit(:title, :description, :company, :url, :category_id)
	end

	def find_task
		@task = Task.find(params[:id])
	end

end