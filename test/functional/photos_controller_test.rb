require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  
  def test_get_show
    get :show, :id => photos(:default).id
    assert_response :success
    assert_template :show
    assert assigns(:photo)
  end
  
end
