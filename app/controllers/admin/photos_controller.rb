class Admin::PhotosController < CmsAdmin::BaseController
  before_filter :load_gallery
  before_filter :load_photo,  :except => [:index, :new, :create, :sort]
  before_filter :build_photo, :only   => [:new, :create]

  def index
    @photos = @gallery.photos.all
  end

  def new
    render
  end

  # def create
  #   @photo.save!
  #   flash[:notice] = 'Photo was successfully created.'
  #   redirect_to admin_gallery_photos_path(@gallery)
  # rescue ActiveRecord::RecordInvalid
  #   render :action => :new
  # end
  
  def create
    # @photo = @gallery.photos.new(params[:photo])
    @photo = @gallery.photos.create!(:image => params[:file])
    # @cms_upload = @cms_site.cms_uploads.create!(:file => params[:file])
    render :partial => 'file', :object => @photo
  rescue ActiveRecord::RecordInvalid
    raise params.to_yaml
    # render :nothing => true, :status => :bad_request
  end


  def edit
    render 
  end

  def update
    @photo.update_attributes!(params[:photo])
    flash[:notice] = 'Photo was successfully updated.'
    redirect_to admin_gallery_photos_path(@gallery)
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  # def destroy
  #   @photo.destroy
  #   flash[:notice] = 'Photo was successfully deleted.'
  #   redirect_to admin_gallery_photos_path(@gallery)
  # end
  def destroy
    @photo.destroy
  end
  
  def sort
    params[:gallery_photos].each_with_index do |photo_id, i|
      photo = Photo.find_by_id(photo_id)
      Photo.update_all(["position = %d", i], ["id = %d", photo_id])
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
