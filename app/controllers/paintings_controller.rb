class PaintingsController < ApplicationController
 
  def index
    @paintings = Painting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paintings }
    end
  end

  def show
    @painting = Painting.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/new
  # GET /paintings/new.json
  def new
    @painting = Painting.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/1/edit
  def edit
    @product = Product.find(params[:id])
    @painting = @product.paintings.create(params[:painting])
     respond_to do |format|
         format.html { redirect_to @painting, notice: 'Painting was successfully created.' }
         format.json { render json: @painting, status: :created, location: @painting }
         format.js
     end
  end

  def create
      @painting = Painting.create(params[:painting])
      @product = Product.first
      if @product.paintings.any?
         picture_first = @product.paintings.first.image_url(:feed).to_s
         @product.update_attribute(:picture, picture_first)
      end
      #if @product.paintings.any?
       #  @product.update_attribute(:picture, @product.paintings.first.image_url(:feed).to_s)
        # logger.debug "parametro envio es: #{@product.paintings.first.image_url.to_s}\n\n\n\n\n\n"
      #end
  end

  def update
    @painting = Painting.find(params[:id])
    respond_to do |format|
      if @painting.update_attributes(params[:painting])
        format.html { redirect_to @painting, notice: 'Painting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @painting = Painting.find(params[:id])
    @painting.destroy
    respond_to do |format|
      format.html { redirect_to paintings_url }
      format.json { head :ok }
      format.js 
    end
  end
end

def find_id
   @paintings = @product.paintings.first
   return @paintings.product_id
end