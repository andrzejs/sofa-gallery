class GalleryAdmin::PhotosController < GalleryAdmin::BaseController
  
  before_filter :load_gallery
  before_filter :load_photo,  :only => [:edit, :update, :destroy]
  before_filter :build_photo, :only => [:new, :create]

  def index
    @photos = @gallery.photos
  end

  def new
    render
  end
  
  def create
    @photo.save!
    flash[:notice] = 'Photo created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Failed to create Photo'
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @photo.update_attributes!(params[:photo])
    flash[:notice] = 'Photo updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to updated Photo'
    render :action => :edit
  end
  
  def destroy
    @photo.destroy
    flash[:notice] = 'Photo deleted'
    redirect_to :action => :index
  end
  
  def reorder
    (params[:photo] || []).each_with_index do |id, index|
      if (photo = Photo.find_by_id(id))
        photo.update_attribute(:position, index)
      end
    end
    render :nothing => true
  end
  
protected
  
  def load_gallery
    @gallery = Sofa::Gallery.find(params[:gallery_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Gallery not found'
    redirect_to gallery_admin_galleries_path
  end
  
  def load_photo
    @photo = @gallery.photos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Photo not found'
    redirect_to :action => :index
  end
  
  def build_photo
    @photo = Sofa::Photo.new({:gallery => @gallery}.merge(params[:photo] || {}))
  end
  
end
