require File.expand_path('../test_helper', File.dirname(__FILE__))

class PhotoTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    SofaGallery::Photo.all.each do |photo|
      assert photo.valid?, photo.errors.full_messages.to_s
    end
  end
  
  def test_validations
    photo = SofaGallery::Photo.new
    assert photo.invalid?
    assert_has_errors_on photo, {:gallery_id=>["can't be blank"], :slug=>["can't be blank", "is invalid"], :image_file_name=>["There was no file uploaded!"]}
  end
  
  def test_creation
    gallery = sofa_gallery_galleries(:default)
    assert_difference 'SofaGallery::Photo.count' do
      SofaGallery::Photo.create!(
        :gallery  => gallery,
        :title    => 'Test Photo',
        :slug     => 'test-photo',
        :image    => fixture_file_upload('/files/default.jpg', 'image/jpeg')
      )
    end
  end
  
end
