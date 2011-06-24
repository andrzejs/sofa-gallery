require File.expand_path('../../test_helper', File.dirname(__FILE__))

class SofaGallery::GalleriesControllerTest < ActionController::TestCase
  
  def test_get_show
    get :show, :id => sofa_galleries(:default)
    assert_response :success
    assert_template :show
    assert assigns(:gallery)
  end
  
  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response 404
    assert_equal 'Gallery not found', flash[:error]
  end
  
end