class ProjectsController < ApplicationController
  # load_and_authorize_resource

  def index
    @projects = Project.all
    @dummy_project = Project.new
    @dummy_project.id = -1
  end

  def destroy
    puts "***********removing: " + params.inspect 
    @project = Project.find(params[:id])
    @project.destroy
    render :nothing => true
    
  end
  
  def show
    @project = Project.find_by_id(params[:id])
    @new_user = User.new
    @dummy_pu = ProjectUser.new
    @dummy_pu.id = -1
  end

  def save
    puts "save me:  " +  params[:project][:id]

    if params[:project][:id] == "-1"
      puts "creating project"
      project = Project.new(params[:project])
    
      project.save!

      actorUser = project.actors.create( \
        :actor_singular_name => "User", \
        :actor_plural_name => "Users", \
        :use_an_instead_of_a =>false)

      storyType = project.story_types.create(:story_type_name => "Basic Task")

      firstStory = project.user_stories.create( \
          :actor_id => actorUser.id, \
          :story_type_id => storyType.id, \
          :want_to => "start a project with an initial dummy story", \
          :so_i_can => "change it to be what I want it to be", \
          :priority => 1, \
          :is_fully_recorded => false, \
          :is_estimate_final => false)

    else
      puts "updating project"
    end

    render :nothing => true
  end

  def update
    puts "************ saving project" + params.inspect 
    @project = Project.find(params[:id])
    puts "************ project:" + @project.inspect 
    @project.update_attributes!(params[:project])
    puts "************ done!" 
    render :nothing => true
  end
end
