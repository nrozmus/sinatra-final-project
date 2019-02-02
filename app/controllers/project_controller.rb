class ProjectController < ApplicationController

    get '/projects' do
        if logged_in?
            @projects = Project.all
            erb :'/projects/index'
        else
            redirect '/login'
        end
    end

    get '/projects/new' do
        if logged_in?
            erb :'/projects/create'
        else
            redirect '/login'
        end
    end

    post '/projects' do
        if params.empty?
            flash[:error] = "All fields must be filled in"
            redirect '/projects/new'
        elsif logged_in? && !params.empty?
            @project = current_user.projects.create(name: params[:name], materials: params[:materials], image_url: params[:image_url], instructions: params[:instructions])
            if @project.save
                redirect "/projects/#{@project.id}"
            else
                flash[:error] = "Your project could not be saved. Try again!"
                redirect '/projects/new'
            end
        else
            flash[:error] = "You must be logged in to see the projects index."
            redirect '/login'
        end
        current_user.save
    end

    get '/projects/:id' do
        if logged_in?
            @project = Project.find_by_id(params[:id])
            erb :'/projects/show'
        else
            flash[:error] = "You must be logged in to view projects."
            redirect '/login'
        end
    end

    get '/projects/:id/edit' do
        @project = Project.find_by_id(params[:id])
        if logged_in? && current_user.projects.include?(@project)
            erb :'/projects/edit'
        else
            flash[:error] = "You must be logged in to edit a project."
            redirect '/login'
        end
    end

    patch '/projects/:id' do
        @project = Project.find_by_id(params[:id])
        if params.empty?
            flash[:error] = "All fields must be filled in"
            redirect "/projects/#{@project.id}/edit"
        elsif logged_in? && !params.empty? && current_user.projects.include?(@project)
            @project.update(name: params[:name], materials: params[:materials], image_url: params[:image_url], instructions: params[:instructions])
            redirect "/projects/#{@project.id}"
        else
            flash[:error] = "You must be logged in."
            redirect '/login'
        end

    end

    delete '/projects/:id/delete' do
        if logged_in?
            @project = Project.find_by_id(params[:id])
            if @project.user == current_user then @project.delete else redirect '/login' end
        else
            flash[:error] = "You must be logged in."
            redirect '/login'
        end
        redirect '/projects'
    end
end
