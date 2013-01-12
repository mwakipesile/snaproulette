class PhotosController < ApplicationController
  
  # get a random valuable photo
  # GET /photos.json
  def index
    @photo = Photo.get(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photo }
    end
  end

  # get replies for a specific device user
  # GET /reply/get
  def get_replies
    respond_to do |format|
      format.json { render json: Photo.find_all_by_recipient_id(params[:user_id]).map{|p| {id: p.id, user_id: p.user_id, updated_at: p.updated_at} } }
    end
  end

  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end

    @photo.destroy
  end

  # post new photo (not reply)
  # POST /photos.json
  def create
    @photo =           Photo.new(params[:photo])
    @photo.file ||=    params[:file]
    @photo.user_id ||= params[:user_id]
    respond_to do |format|
      if @photo.save
        format.html { render text: "OK"}
        format.json { render json: {status: "OK"}}
      else
        format.html { render text: "FAIL"}
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # post a reply
  # POST /reply/new
  def create_reply
    @receiving_photo=Photo.find(params[:original_photo_id].to_i)
    @receiving_photo.hits+=1
    @receiving_photo.save

    @reply =           Photo.new(params[:photo])
    @reply.file ||=    params[:file]
    @reply.user_id ||= params[:user_id]

    respond_to do |format|
      if @reply.save
        format.html { render text: "OK"}
        format.json { render json: {status: "OK"}}
      else
        format.html { render text: "FAIL"}
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def delete_all
    Photo.all.each do |ph|
      ph.delete
    end
  end
end
