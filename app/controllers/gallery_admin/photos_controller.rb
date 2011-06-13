class GalleryAdmin::PhotosController < GalleryAdmin::BaseController
  
  before_filter :load_gallery
  before_filter :load_photo,  :only => [:edit, :update, :destroy]
  before_filter :build_photo, :only   => [:new, :create]

  def index
    @photos = @gallery.photos.all
  end

  def new
    render
  end
  
  def create
    p 'AAAAA', @photo
    
    @photo = @gallery.photos.create!(:image => params[:file])
    
    render :partial => 'file', :object => @photo
  rescue ActiveRecord::RecordInvalid
    render :nothing => true, :status => :bad_request
  end


  def edit
    render 
  end

  def update
    @photo.update_attributes!(params[:photo])
    flash[:notice] = 'Photo was successfully updated.'
    redirect_to cms_admin_gallery_photos_path(@gallery)
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @photo.destroy
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
    @gallery = Gallery.find(params[:gallery_id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
  end

  def load_photo
    @photo = @gallery.photos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Photo not found', :status => 404
  end
  
  def build_photo
    @photo = @gallery.photos.new(params[:photo])
  end
  
end
