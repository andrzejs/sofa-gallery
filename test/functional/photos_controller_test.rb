require File.expand_path('../test_helper', File.dirname(__FILE__))

class GalleryAdmin::PhotosControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index, :gallery_id => sofa_galleries(:default)
    assert_response :success
    assert_template 'index'
    assert assigns(:photos)
  end
  
  def test_get_index_failure
    get :index, :gallery_id => 'invalid'
    assert_response :redirect
    assert_redirected_to gallery_admin_galleries_path
    assert_equal 'Gallery not found', flash[:error]
  end
  
  def test_new
    gallery = sofa_galleries(:default)
    get :new, :gallery_id => gallery
    assert_response :success
    assert_template 'new'
    assert assigns(:photo)
    assert_select "form[action='/cms-admin/galleries/#{gallery.id}/photos']"
  end

  def test_creation
    assert_difference 'Sofa::Photo.count' do
      post :create, :gallery_id => sofa_galleries(:default), :photo => {
        :title  => 'Test Photo',
        :slug   => 'test-photo',
        :image  => fixture_file_upload('/files/default.jpg', 'image/jpeg')
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Photo created', flash[:notice]
    end
  end

  def test_creation_fail
    assert_no_difference 'Sofa::Photo.count' do
      post :create, :gallery_id => sofa_galleries(:default), :photo => { }
      assert_response :success
      assert_template 'new'
      assert_equal 'Failed to create Photo', flash[:error]
    end
  end
  
  def test_get_edit
    photo = sofa_photos(:default)
    get :edit, :gallery_id => photo.gallery, :id => photo
    assert_response :success
    assert_template 'edit'
    assert_select "form[action='/cms-admin/galleries/#{photo.gallery.id}/photos/#{photo.id}']"
  end
  
  def test_get_edit_failure
    get :edit, :gallery_id => sofa_galleries(:default), :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo not found', flash[:error]
  end
  
  def test_update
    photo = sofa_photos(:default)
    put :update, :gallery_id => photo.gallery, :id => photo, :photo => {
      :title => 'Updated Title'
    }
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo updated', flash[:notice]
    
    photo.reload
    assert_equal 'Updated Title', photo.title
  end
  
  def test_update_failure
    photo = sofa_photos(:default)
    put :update, :gallery_id => photo.gallery, :id => photo, :photo => {
      :title => 'Updated Title',
      :image => fixture_file_upload('/files/default.txt', 'text/plain')
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to updated Photo', flash[:error]
    
    photo.reload
    assert_not_equal 'Updated Title', photo.description
  end
  
  def test_destroy
    photo = sofa_photos(:default)
    assert_difference 'Sofa::Photo.count', -1 do
      delete :destroy, :gallery_id => photo.gallery, :id => photo
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Photo deleted', flash[:notice]
    end
  end
  
  def test_reorder
    photo = sofa_photos(:default)
    assert_equal 0, photo.position
    xhr :post, :reorder, :gallery_id => photo.gallery, :sofa_photo => ['dummy', photo.id]
    assert_response :success
    
    photo.reload
    assert_equal 1, photo.position
  end
  
  def test_get_crop
    photo = sofa_photos(:default)
    photo.image = fixture_file_upload('/files/default.jpg', 'image/jpeg')
    photo.save!
    
    get :crop, :gallery_id => photo.gallery, :id => photo
    assert_response :success
    assert_template 'crop'
    assert assigns(:photo)
  end
  
end
