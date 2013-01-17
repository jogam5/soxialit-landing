class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    if params[:tag]
      @projects = Project.tagged_with(params[:tag])
    else
      @projects = Project.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @pictures = @project.pictures.find(:all)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @pictures = @project.pictures.find(:all)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project }
        format.json { render json: current_user, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    
      if @project.pictures.any?
         logger.debug "position: #{params[:position]}\n\n\n\n\n\n"
         if params[:position].nil?
         else
            logger.debug "postion: #{params[:position]}\n\n\n\n\n\n"
            picture = Picture.find(params[:position])
            logger.debug "picture: #{picture}\n\n\n\n\n\n"
            @project.update_attribute(:picture, picture.image_url(:timeline).to_s)
         end
      end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to current_user, notice: 'El proyecto fue actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
  
  def change_position
     @project = Project.find(params[:id])
     logger.debug "position: #{params[:position]}\n\n\n\n\n\n"
        logger.debug "position: #{params[:position]}\n\n\n\n\n\n"
        if params[:position].nil?
        else
           logger.debug "position: #{params[:position]}\n\n\n\n\n\n"
           picture = Picture.find(params[:position])
           logger.debug "picture: #{picture}\n\n\n\n\n\n"
           @project.update_attribute(:picture, picture.image_url(:timeline).to_s)
        end
        @project.activities.create(:user_id => current_user.id, :action => "create")
     respond_to do |format|
     if @project.update_attributes(params[:project])
        format.html { redirect_to current_user, notice: 'El proyecto fue creado correctamente' }
        format.js
       else
         format.json { render json: @project.errors, status: :unprocessable_entity }
         format.js
       end
     end
   end
end
