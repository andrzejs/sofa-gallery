class CmsAdmin::GalleriesController < CmsAdmin::BaseController
  before_filter :load_gallery,  :except => [:index, :new, :create]
  before_filter :build_gallery, :only   => [:new, :create]

  def index
    @galleries = Gallery.all
  end

  def new
  end

  def create
    @gallery.save!
    flash[:notice] = 'Gallery was successfully created.'
    redirect_to :action => :index   
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def show
  end

  def edit 
  end

  def update
    @gallery.update_attributes!(params[:gallery])
    flash[:notice] = 'Gallery was successfully updated.'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  def destroy
    @gallery.destroy
    flash[:notice] = 'Gallery was successfully deleted.'
    redirect_to :action => :index
  end

protected

  def load_gallery
    @gallery = Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
  end

  def build_gallery
    @gallery = Gallery.new(params[:gallery])
  end
end
