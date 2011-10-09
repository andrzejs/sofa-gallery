require File.expand_path('../../test_helper', File.dirname(__FILE__))

class SofaGallery::Admin::PhotosControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index, :gallery_id => sofa_gallery_galleries(:default)
    assert_response :success
    assert_template 'index'
    assert assigns(:photos)
  end
  
  def test_get_index_failure
    get :index, :gallery_id => 'invalid'
    assert_response :redirect
    assert_redirected_to sofa_gallery_admin_galleries_path
    assert_equal 'Gallery not found', flash[:error]
  end
  
  def test_new
    gallery = sofa_gallery_galleries(:default)
    get :new, :gallery_id => gallery
    assert_response :success
    assert_template 'new'
    assert assigns(:photo)
    assert_select "form[action='/admin/galleries/#{gallery.id}/photos']"
  end

  def test_create
    assert_difference 'SofaGallery::Photo.count' do
      post :create, :gallery_id => sofa_gallery_galleries(:default), :sofa_gallery_photo => {
        :title  => 'Test Photo',
        :slug   => 'test-photo',
        :image  => [fixture_file_upload('/files/default.jpg', 'image/jpeg')]
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Photo created', flash[:notice]
      
      photo = SofaGallery::Photo.last
      assert_equal 'Test Photo', photo.title
      assert_equal 'test-photo', photo.slug
    end
  end
  
  def test_create_without_title_or_slug
    assert_difference 'SofaGallery::Photo.count', 2 do
      post :create, :gallery_id => sofa_gallery_galleries(:default), :sofa_gallery_photo => {
        :image  => [fixture_file_upload('/files/default.jpg', 'image/jpeg')]
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Photo created', flash[:notice]
      
      photo = SofaGallery::Photo.last
      assert_equal 'default.jpg', photo.title
      assert_equal 'default-jpg', photo.slug
      
      post :create, :gallery_id => sofa_gallery_galleries(:default), :sofa_gallery_photo => {
        :slug   => 'Testrrr',
        :image  => [fixture_file_upload('/files/default.jpg', 'image/jpeg')]
      }
      
      photo = SofaGallery::Photo.last
      assert_equal 'default.jpg', photo.title
      assert_equal 'Testrrr', photo.slug
    end
  end

  def test_create_failure
    assert_no_difference 'SofaGallery::Photo.count' do
      post :create, :gallery_id => sofa_gallery_galleries(:default), :sofa_gallery_photo => { }
      assert_response :success
      assert_template 'new'
      assert_equal 'Failed to create Photo', flash[:error]
    end
  end
  
  
  def test_create_multiple
    SofaGallery::Photo.delete_all
    
    assert_difference 'SofaGallery::Photo.count', 2 do
      post :create, :gallery_id => sofa_gallery_galleries(:default), :sofa_gallery_photo => {
        :title  => 'Test Photo',
        :slug   => 'test-photo',
        :image  => [
          fixture_file_upload('/files/default.jpg', 'image/jpeg'),
          fixture_file_upload('/files/default.jpg', 'image/jpeg')
        ]
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      
      photo_a, photo_b = SofaGallery::Photo.all
      
      assert_equal 'default.jpg', photo_a.image_file_name
      assert_equal 'default.jpg', photo_b.image_file_name
      assert_equal 'Test Photo 1', photo_a.title
      assert_equal 'Test Photo 2', photo_b.title
      assert_equal 'test-photo-1', photo_a.slug
      assert_equal 'test-photo-2', photo_b.slug
      assert_equal 'Photo created', flash[:notice]
    end
  end
  
  
  def test_get_edit
    photo = sofa_gallery_photos(:default)
    get :edit, :gallery_id => photo.gallery, :id => photo
    assert_response :success
    assert_template 'edit'
    assert_select "form[action='/admin/galleries/#{photo.gallery.id}/photos/#{photo.id}']"
  end
  
  def test_get_edit_failure
    get :edit, :gallery_id => sofa_gallery_galleries(:default), :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo not found', flash[:error]
  end
  
  def test_update
    photo = sofa_gallery_photos(:default)
    put :update, :gallery_id => photo.gallery, :id => photo, :sofa_gallery_photo => {
      :title => 'Updated Title'
    }
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo updated', flash[:notice]
    
    photo.reload
    assert_equal 'Updated Title', photo.title
  end
  
  def test_update_failure
    photo = sofa_gallery_photos(:default)
    put :update, :gallery_id => photo.gallery, :id => photo, :sofa_gallery_photo => {
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
    photo = sofa_gallery_photos(:default)
    assert_difference 'SofaGallery::Photo.count', -1 do
      delete :destroy, :gallery_id => photo.gallery, :id => photo
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Photo deleted', flash[:notice]
    end
  end
  
  def test_reorder    
    gallery = sofa_gallery_galleries(:default)
    photo_one = sofa_gallery_photos(:default)
    photo_two = SofaGallery::Photo.create!(
      :gallery  => gallery,
      :title    => 'Test Photo',
      :slug     => 'test-photo',
      :image    => fixture_file_upload('/files/default.jpg', 'image/jpeg')
    )
    assert_equal 0, photo_one.position
    assert_equal 1, photo_two.position

    post :reorder, :gallery_id => photo_one.gallery, :sofa_gallery_photo => [photo_two.id, photo_one.id]
    assert_response :success
    photo_one.reload
    photo_two.reload

    assert_equal 1, photo_one.position
    assert_equal 0, photo_two.position
  end
  
  def test_get_crop
    photo = sofa_gallery_photos(:default)
    photo.image = fixture_file_upload('/files/default.jpg', 'image/jpeg')
    photo.save!
    
    get :crop, :gallery_id => photo.gallery, :id => photo
    assert_response :success
    assert_template 'crop'
    assert assigns(:photo)
  end
  
  def test_crop_thumbnail
    photo = sofa_gallery_photos(:default)
    put :update, :gallery_id => photo.gallery, :id => photo, :photo => {
      :thumb_crop_x => '0', 
      :thumb_crop_y => '0', 
      :thumb_crop_w => '100', 
      :thumb_crop_h => '100'
    }
    
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo updated', flash[:notice]
  end
  
  
  def test_crop_thumbnail_and_full
    gallery = SofaGallery::Gallery.create!(
      :title            => "Title",
      :slug             => "title",
      :force_ratio_full => true
    )
    photo = SofaGallery::Photo.create!(
      :gallery  => gallery,
      :title    => 'Test Photo',
      :slug     => 'test-photo',
      :image    => fixture_file_upload('/files/default.jpg', 'image/jpeg')
    )
    put :update, :gallery_id => gallery, :id => photo, :photo => {
      :thumb_crop_x => '0', 
      :thumb_crop_y => '0', 
      :thumb_crop_w => '100', 
      :thumb_crop_h => '100',
      :full_crop_x => '0', 
      :full_crop_y => '0', 
      :full_crop_w => '100', 
      :full_crop_h => '100'
    }
    
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Photo updated', flash[:notice]
  end
  
end
