class TodosController < ApplicationController
    before_action :validate_url_id, only: [:edit, :update, :destroy]

    def index
        @todos = Todo.all
    end

    def new
        @todo = Todo.new
    end

    def create
        @todo = Todo.new(todo_params)
        @todo.priority = params[:priority]
        if @todo.save()
            flash[:success] = "Item created."
            redirect_to todos_path
        else
            render 'new'
        end
    end

    def edit
        @todo = Todo.find(params[:id])
        @priority_default = @todo.priority
    end

    def update
        @todo = Todo.find(params[:id])
        if @todo.update(content: params[:todo][:content], due_date: params[:todo][:due_date], priority: params[:priority])
            flash[:success] = "Item updated."
            redirect_to todos_path
        else
            render 'edit'
        end
    end

    def destroy
        todo = Todo.find(params[:id])
        if todo.destroy
            flash[:success] = "Item deleted."
        else
            flash[:error] = "Item could not be deleted."
        end
        redirect_to todos_path
    end

    private

    def todo_params
        params[:todo].permit(:content, :due_date)
    end
    
    def validate_url_id
        if !Todo.exists?(params[:id])
            redirect_to todos_path
        end
    end
end
