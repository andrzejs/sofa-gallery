require File.expand_path('../test_helper', File.dirname(__FILE__))

class SofaGallery::GalleriesControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:galleries)
  end
  
  def test_get_show
    get :show, :id => sofa_gallery_galleries(:default)
    assert_response :success
    assert_template :show
    assert assigns(:gallery)
  end
  
  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response 404
  end
  
end