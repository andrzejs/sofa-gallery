
$(document).ready(function() {
  // Homepage banner

  // $("#slidetabs").tabs("#homepage_banner > .slide", {
  //   effect: 'fade',
  //   rotate: true
  // }).slideshow({
  //   clickable: false,
  //   autoplay: true,
  //   interval: 5000
  // });
  
  // $('a.fancybox').fancybox();
  // $("a.grouped_elements").fancybox();
  
  $("a[rel^='prettyPhoto']").prettyPhoto({
      theme: 'facebook',
      animation_speed: 'fast',
      opacity: 0.8,
      show_title: true,
      allow_resize: false,
      overlay_gallery: false,
      markup: '<div class="pp_pic_holder"> \
            <div class="ppt">&nbsp;</div> \
            <div class="pp_top"> \
              <div class="pp_left"></div> \
              <div class="pp_middle"></div> \
              <div class="pp_right"></div> \
            </div> \
            <div class="pp_content_container"> \
              <div class="pp_left"> \
              <div class="pp_right"> \
                <div class="pp_content"> \
                  <div class="pp_loaderIcon"></div> \
                  <div class="pp_fade"> \
                    <div class="pp_hoverContainer"> \
                      <a class="pp_next" href="#">next</a> \
                      <a class="pp_previous" href="#">previous</a> \
                    </div> \
                    <div id="pp_full_res"></div> \
                    <div class="pp_details clearfix"> \
                      <p class="pp_description"></p> \
                      <a class="pp_close" href="#">Close</a> \
                      <div class="pp_nav"> \
                        <a href="#" class="pp_arrow_previous">Previous</a> \
                        <p class="currentTextHolder">0/0</p> \
                        <a href="#" class="pp_arrow_next">Next</a> \
                      </div> \
                    </div> \
                  </div> \
                </div> \
              </div> \
              </div> \
            </div> \
            <div class="pp_bottom"> \
              <div class="pp_left"></div> \
              <div class="pp_middle"></div> \
              <div class="pp_right"></div> \
            </div> \
          </div> \
          <div class="pp_overlay"></div>',
    });
  $.localScroll({
      hash: true,
      duration: 500,
      easing: 'swing'
    });
})