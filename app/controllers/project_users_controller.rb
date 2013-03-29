class ProjectUsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:destroy]

  def create
    puts "*********** ADDING USER TO PROJECT"
    user = User.find_by_email(params[:user][:email])
    
    if user.nil?
      puts "*********** creating user"
      user = User.new(params[:user])
      user.provider = "invitee"
      user.save
      puts "*********** creating user"
    else
      puts "*********** user already existed"
    end

    @project = Project.find_by_id(params[:project_id])

    puts "got project: " + @project.inspect

    project_user = ProjectUser.find_by_project_id_and_user_id(@project.id, user.id)
    
    puts "got project user" + project_user.inspect

    puts "roles???  " + ProjectUser::ROLES.map{|role| role[0].to_s}.inspect

    if project_user.nil?
      puts "*********** CREATING PROJECT USER"
      project_user = ProjectUser.new(:project_id => @project.id, :user_id => user.id, :role=> "view")
      project_user.save!
    else
      puts "*********** USER ALREADY IN PROJECT"
    end
    render :nothing => true
  end

  def update
    puts "***********changing: " + params.inspect 
    @project = Project.find(params[:project_id])
    @project_user = @project.project_users.find(params[:id])

    puts "*********** setting role to " + params[:role]
    @project_user.role = params[:role]
    @project_user.save
    render :nothing => true
  end

  def destroy
    puts "***********removing: " + params.inspect 
    @project = Project.find(params[:project_id])
    @project_user = @project.project_users.find(params[:id])
    @project_user.destroy
    render :nothing => true
  end
end
