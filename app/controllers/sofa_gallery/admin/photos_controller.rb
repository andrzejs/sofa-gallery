class SofaGallery::Admin::PhotosController < SofaGallery::Admin::BaseController
  
  before_filter :load_gallery
  before_filter :load_photo,  :only => [:edit, :update, :destroy, :crop]
  before_filter :build_photo, :only => [:new, :create]

  def index
    @photos = @gallery.photos
  end

  def new
    render
  end
  
  def create
    file_array  = params[:sofa_gallery_photo][:image] || [nil]
    
    file_array.each_with_index do |file, i|
      file_params = params[:sofa_gallery_photo].merge(:image => file)
      
      title = (file_params[:title].blank? && file_params[:image] ? 
        file_params[:image].original_filename : 
        file_params[:title]
      )
      title = title + " #{i + 1}" if file_params[:title] == title && file_array.size > 1
      
      slug = (file_params[:slug].blank? && file_params[:image] ? 
        file_params[:image].original_filename.parameterize : 
        file_params[:slug]
      )
      slug = (slug + "-#{i + 1}") if file_params[:slug] == slug && file_array.size > 1
      
      @photo = SofaGallery::Photo.new({:gallery => @gallery}.merge(file_params.merge(:title => title, :slug => slug) || {}))
      @photo.save!
    end
    
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
    @photo.update_attributes!(params[:sofa_gallery_photo])
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
    (params[:sofa_gallery_photo] || []).each_with_index do |id, index|
      if (photo = SofaGallery::Photo.find_by_id(id))
        photo.update_attribute(:position, index)
      end
    end
    render :nothing => true
  end
  
  def crop
    render
  end
  
protected
  
  def load_gallery
    @gallery = SofaGallery::Gallery.find(params[:gallery_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Gallery not found'
    redirect_to sofa_gallery_admin_galleries_path
  end
  
  def load_photo
    @photo = @gallery.photos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Photo not found'
    redirect_to :action => :index
  end
  
  def build_photo
    @photo = SofaGallery::Photo.new({:gallery => @gallery}.merge(params[:sofa_gallery_photo] || {}))
  end
  
end
