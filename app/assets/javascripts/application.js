// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var path = window.location.pathname.split('/')[1] || 'home';
var nav = $('nav ul a').removeClass("active");
$.each(nav, function() {
  var linkPath = $(this).attr('href').split('/')[1];
  if (linkPath === path) {
    $(this).addClass('active')
  }
});




// Set Router For Cold Entries
function setRouter() {
  if ($('.sidebar').length === 0) {
    var path = {href: window.location.pathname};
    $('.content').hide();
    $('.content').load('/', function() {
      routeTo(path);
      $('.content').fadeIn('slow');
    });
  }
};
setRouter();

// Route to Destination & Save History State
function routeTo(dest) {
  var url = dest.href;
  history.pushState(url, null, url);
  event.preventDefault();
  $('main').load(url);
};

// Load History State
window.addEventListener('popstate', function(e) {
  if (e.state) {
    $('main').load(e.state);
  }else{
    $('main').load("/home");
  }
});

// Scroll-to (animated)
function scrollTo(dest) {
  var anchor = $("#"+dest);
  event.preventDefault();
  $('html,body').animate({
    scrollTop: anchor.offset().top
  }, 1000);
};
