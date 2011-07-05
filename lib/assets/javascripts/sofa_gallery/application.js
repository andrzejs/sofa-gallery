//= require sofa_gallery/jquery.js
//= require sofa_gallery/jquery_ui.js
//= require sofa_gallery/rails.js

$.SofaGallery = function(){
  $(function(){
    $('.sortable').sortable({
      handle: '.dragger',
      axis:   'y',
      update: function(){
        $.post(window.location.pathname + '/reorder', '_method=put&'+$(this).sortable('serialize'));
      }
    });
  });
}();