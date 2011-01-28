$.CMS_Gallery = function(){
  var current_path = window.location.pathname;
  var admin_path_prefix = current_path.split('/')[1]
  
  $(document).ready(function(){
    if($('#file_container').get(0))  $.CMS_Gallery.enable_photo_uploader();
  });
  
  return {
    enable_photo_uploader : function(){
      var photos_path = '/' + current_path.split('/')[1] + '/' +
                       current_path.split('/')[2] + '/' +
                       current_path.split('/')[3] + '/' +
                       current_path.split('/')[4]
                       
      auth_token = $("meta[name=csrf-token]").attr('content');
      var uploader = new plupload.Uploader({
        container:        'file_container',
        browse_button:    'pickfiles',
        runtimes:         'html5',
        unique_names:     true,
        multipart:        true,
        multipart_params: { authenticity_token: auth_token, format: 'js' },
         url:              photos_path
      });

      uploader.bind('Init', function(up, params) {
        $('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
      });

      $('#uploadfiles').click(function(e) {
        uploader.start();
        e.preventDefault();
      });

      uploader.init();

      uploader.bind('FilesAdded', function(up, files) {
        $.each(files, function(i, file) {
          $('#filelist').append(
            '<div id="' + file.id + '">' +
            file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
          '</div>');
        });
      });

      uploader.bind('UploadProgress', function(up, file) {
        $('#' + file.id + " b").html(file.percent + "%");
      });

      uploader.bind('Error', function(up, err) {
        $('#filelist').append("<div>Error: " + err.code +
          ", Message: " + err.message +
          (err.file ? ", File: " + err.file.name : "") +
          "</div>"
        );
      });

      uploader.bind('FileUploaded', function(up, file, response) {
        $('#' + file.id + " b").html("100%");
        $('ul#gallery_photos').append(response.response);
      });
    }
  }
}();