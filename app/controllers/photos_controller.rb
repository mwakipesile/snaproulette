class PhotosController < ApplicationController
  
  #get a random valuable photo
  def index
    @photo = Photo.get_top

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photo }
    end
  end

  #get replies for a specific device user
  def get_replies
    @photos= Photo.find_by_recipient_id(params[:user_id])
    respond_to do |format|
      format.html
      format.json { render json: @photos}
    end
  end

  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  #post new photo (not reply)
  def create
    @photo = Photo.new(params[:photo])
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def create_reply
    @receiving_photo=Photo.find(:original_photo_id)
    @receiving_photo.hits+=1
    @receiving_photo.save

    @reply=Photo.new(params[:photo])
    if @reply.save
      format.html { redirect_to @reply, notice: 'Photo was successfully created.' }
      format.json { render json: @reply, status: :created, location: @reply }
    else
      format.html { render action: "new" }
      format.json { render json: @reply.errors, status: :unprocessable_entity }
    end

  end


end
