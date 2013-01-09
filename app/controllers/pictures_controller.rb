class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.json
=begin
  def index
    @pictures = Picture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @project = Project.find(params[:project_id]) 
    @picture = @project.pictures.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @picture = @project.pictures.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.create(params[:picture])
    @project = Project.find(@picture.project_id)
    picture_first = @project.pictures.first.image_url(:timeline).to_s
    logger.debug "picture: #{picture_first}\n\n\n\n\n\n"
    @project.update_attribute(:picture, picture_first)
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
      format.js
    end
  end
end
=end

 def new
   @project = Project.find(params[:project_id]) 
   @picture = @project.pictures.build

   respond_to do |format|
     format.html # new.html.erb
     format.json { render json: @picture }
   end
 end
 
  def destroy
     @picture = Picture.find(params[:id])
     @picture.destroy

     respond_to do |format|
       format.html { redirect_to pictures_url }
       format.json { head :no_content }
       format.js
     end
   end
 
 def update
     @picture = Picture.find(params[:id])

     respond_to do |format|
       if @picture.update_attributes(params[:picture])
         format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
         format.json { head :no_content }
       else
         format.html { render action: "edit" }
         format.json { render json: @picture.errors, status: :unprocessable_entity }
       end
     end
   end
   
   def create
     @picture = Picture.create(params[:picture])
     @project = Project.find(@picture.project_id)
     picture_first = @project.pictures.first.image_url(:timeline).to_s
     logger.debug "picture: #{picture_first}\n\n\n\n\n\n"
     @project.update_attribute(:picture, picture_first)
   end
end
 
