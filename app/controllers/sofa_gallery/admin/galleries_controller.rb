class SofaGallery::Admin::GalleriesController < SofaGallery::Admin::BaseController
  
  before_filter :load_gallery,  :except => [:index, :new, :create]
  before_filter :build_gallery, :only   => [:new, :create]
  
  def index
    if params[:category].present?
      @galleries = SofaGallery::Gallery.for_category(params[:category]).all
    else
      @galleries = SofaGallery::Gallery.all
    end
  end
  
  def new
    render
  end
  
  def create
    @gallery.save!
    flash[:notice] = 'Gallery created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Gallery'
    render :action => :new
  end
  
  def show
    render
  end
  
  def edit
    render
  end
  
  def update
    @gallery.update_attributes!(params[:gallery])
    flash[:notice] = 'Gallery updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Gallery'
    render :action => :edit
  end
  
  def destroy
    @gallery.destroy
    flash[:notice] = 'Gallery deleted'
    redirect_to :action => :index
  end
  
protected
  
  def load_gallery
    @gallery = SofaGallery::Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Gallery not found'
    redirect_to :action => :index
  end
  
  def build_gallery
    @gallery = SofaGallery::Gallery.new(params[:gallery])
  end
  
end
