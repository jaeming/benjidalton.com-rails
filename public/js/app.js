$( document ).ready(function() {

  $('nav a, header a').on('click', function() {
      var scrollAnchor = $(this).attr('data-scroll'),
          scrollPoint = $('section[data-anchor="' + scrollAnchor + '"]').offset().top - 28;
      $('body,html').animate({
          scrollTop: scrollPoint
      }, 500);
      return false;
  });

  $('.mobile-menu').click(function() {
    $('.sidebar').addClass('mobile-nav-showing');
    $('.mobile-menu').addClass('mobile-menu-hide');
    $('.mobile-menu-dismiss').addClass('mobile-menu-dismiss-show');
  });

  $('.mobile-menu-dismiss, .sidebar, main, .menu a').click(function() {
    console.log('clicked');
    $('.sidebar').removeClass('mobile-nav-showing');
    $('.mobile-menu').removeClass('mobile-menu-hide');
    $('.mobile-menu-dismiss').removeClass('mobile-menu-dismiss-show');
  });

  $(window).scroll(function() {
      var windscroll = $(window).scrollTop();
      if (windscroll >= 100) {
          $('section').each(function(i) {
              if ($(this).position().top <= windscroll + 160) {
                  $('.menu li.active').removeClass('active');
                  $('.menu li').eq(i).addClass('active');
              }
          });
      } else {
          $('nav').removeClass('fixed');
          $('nav li.active').removeClass('active');
          $('nav li:first').addClass('active');
      }
  }).scroll();
});
