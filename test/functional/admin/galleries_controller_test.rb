require 'test_helper'

class Admin::GalleriesControllerTest < ActionController::TestCase
  
  def test_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_create
    assert_difference 'Gallery.count', 1 do
      post :create, :gallery => {
        :title => 'New Gallery',
        :slug => 'new-gallery',
        :description => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation'
      }
    end
    assert_equal 'Gallery was successfully created.', flash[:notice]
    assert_redirected_to admin_galleries_path
  end

  def test_create_fail
    assert_no_difference 'Gallery.count' do
      post :create, :gallery => { :title => '' }
    end
    assert_response :success
    assert_template 'new'
  end

  def test_edit
    get :edit, :id => galleries(:default)
    assert_response :success
    assert_template 'edit'
  end

  def test_update
    gallery = galleries(:default)
    put :update, :id => gallery, :gallery => {:title => 'New Title'}
    gallery.reload
    assert_equal 'New Title', gallery.title
    assert_equal 'Gallery was successfully updated.', flash[:notice]
    assert_redirected_to admin_galleries_path
  end

  def test_update_fail
    put :update, :id => galleries(:default), :gallery => { :title => '' }
    assert_response :success
    assert_template 'edit'
  end

  def test_destroy
    assert_difference 'Gallery.count', -1 do
      delete :destroy, :id => galleries(:default)
    end
    assert_equal 'Gallery was successfully deleted.', flash[:notice]
    assert_redirected_to admin_galleries_path
  end
  
end
