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

// Set Active class on nav
var path = window.location.pathname.split('/')[1] || 'home';
var nav = $('nav ul a').removeClass("active");
$.each(nav, function() {
  var linkPath = $(this).attr('href').split('/')[1];
  if (linkPath === path) {
    $(this).addClass('active')
  }
});

// Component Constructor
function Component() {
  this.states = {};
  this.actions = {};
}

///// Registered Components
var header = new Component();
header.states = {
  homeURL: function() {
    var url = window.location.pathname.split('/')[1] || 'home';
    this.condition = (url === 'home');
    return condition
  }
}


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

// hides element Based on url
function viewIf() {
  var elements = $('view-if');
  $.each(elements, function() {
    var elseCond = $(this).find('view-else');
    var data = this.dataset;
    var component = Object.keys(data)[0];
    var state = window[component].states[data[component]]

    if (state() === true) {
      $(this).children().show()
      elseCond.hide();
    }else{
      $(this).children().hide();
      elseCond.show();
    }
  });
}
viewIf();

// Bio avatar animation grow
var avatar = {fired: false};

function avatarGrow() {
  if (avatar.fired === false) {
    $('.sidebar_avatar').addClass('sidebar_avatar-grow');
    avatar.fired = true;
  }
};
function avatarShrink() {
  $('.sidebar_avatar').removeClass('sidebar_avatar-grow');
};

$('.sidebar_avatar').one("mouseenter", function() {
  avatarGrow();
  setTimeout(avatarShrink, 4000);
});

function autoAvatarAnimation() {
    setTimeout(avatarGrow, 1000);
    setTimeout(avatarShrink, 4000);
};

setTimeout(autoAvatarAnimation, 35000);

// Fade in about section photo
$("#about .section-photo-cont").hide()
$(window).one("scroll", function() {
  $("#about .section-photo-cont").fadeIn(1800)
});
