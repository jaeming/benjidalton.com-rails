$( document ).ready(function() {
  $('nav a, header a').on('click', function() {
      var scrollAnchor = $(this).attr('data-scroll'),
          scrollPoint = $('section[data-anchor="' + scrollAnchor + '"]').offset().top - 28;
      $('body,html').animate({
          scrollTop: scrollPoint
      }, 500);
      return false;
  })

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
