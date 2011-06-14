require File.expand_path('../test_helper', File.dirname(__FILE__))

class PhotoTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Sofa::Photo.all.each do |photo|
      assert photo.valid?, photo.errors.full_messages.to_s
    end
  end
  
  def test_validations
    photo = Sofa::Photo.new
    assert photo.invalid?
    assert_has_errors_on photo, :image_file_name
  end
  
  def test_creation
    gallery = sofa_galleries(:default)
    assert_difference 'Sofa::Photo.count' do
      Sofa::Photo.create!(
        :gallery  => gallery,
        :title    => 'Test Photo',
        :slug     => 'test-photo',
        :image    => fixture_file_upload('/files/default.jpg', 'image/jpeg')
      )
    end
  end
  
end
