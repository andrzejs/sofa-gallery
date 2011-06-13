require File.expand_path('../test_helper', File.dirname(__FILE__))

class PhotoTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Sofa::Photo.all.each do |photo|
      assert photo.valid?, photo.errors.full_messages.to_s
    end
  end
  
  def test_validations
    gallery = Sofa::Gallery.new
    assert gallery.invalid?
    assert_has_errors_on gallery, [:title, :slug]
  end
  
  def test_creation
    assert_difference 'Sofa::Gallery.count' do
      Sofa::Gallery.create!(
        :title  => 'Test Gallery',
        :slug   => 'test-gallery'
      )
    end
  end
  
end
