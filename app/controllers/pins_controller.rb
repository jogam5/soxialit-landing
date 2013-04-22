class PinsController < ApplicationController

def new
    @gallery = Gallery.find(params[:gallery_id])
    @pin = @gallery.pins.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end


def create
    @pin = Pin.new(params[:pin])

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Item was successfully created.' }
        format.json { render json: @pin, status: :created, location: @pin }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end  
end