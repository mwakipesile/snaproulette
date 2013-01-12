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
    @photos= []
    Photo.find_by_recipient_id(params[:user_id]).each do |p| 
      @photos.add p.id 
    end
    respond_to do |format|
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
    @photo.file ||= params[:file]
    @photo.user_id ||= params[:user_id]
    respond_to do |format|
      if @photo.save
        format.html {render text: "OK"}
        format.json { render json: {status: "OK"}}
      else
        format.html {render text: @photo.errors.inspect}
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def create_reply
    @receiving_photo=Photo.find(:original_photo_id)
    @receiving_photo.hits+=1
    @receiving_photo.save

    @reply=Photo.new(params[:photo])
    @reply.file ||= params[:file]
    @reply.user_id ||= params[:user_id]

    if @reply.save
      format.html {render text: "OK"}
      format.json { render json: {status: "OK"}}
    else
      format.html {render text: "FAIL"}
      format.json { render json: @reply.errors, status: :unprocessable_entity }
    end

  end

  def delete_all
    Photo.all.each do |ph|
      ph.delete
    end
  end


end
