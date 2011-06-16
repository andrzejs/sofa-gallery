SofaGallery
===========

SofaGallery is an image gallery engine for Rails 3.1 apps. As a bonus it integrates seamlessly with ComfortableMexicanSofa (microCMS)

Installation
------------
Add gem definition to your Gemfile:
    
    gem 'sofa_gallery'
    
Then from the Rails project's root run:
    
    bundle install
    rails generate sofa_gallery
    rake db:migrate

Usage
-----
You can immediately access admin area by going to /admin/galleries.

If you are using SofaGallery on it's own take a look in the initializer: [/config/initializers/sofa\_gallery.rb](https://github.com/twg/sofa-gallery/blob/master/config/initializers/sofa_gallery.rb)
You probably want to set the admin controller to be something that handles user authentication within your app. Same goes for the admin\_route\_prefix.

If you are using SofaGallery in conjunction with ComfortableMexicanSofa everything will be configured automatically.


CMS Gallery is released under the [MIT license](https://github.com/twg/sofa-gallery/raw/master/LICENSE) 

Copyright 2011 The Working Group