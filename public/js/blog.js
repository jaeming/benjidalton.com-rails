$.getJSON('http://benji.herokuapp.com/api/recent_posts', function(data) {
  $.each(data.articles, function() {
    $('#posts').append('<div class="post-box"><h3 class="post-title">' + this.title + '</h3>' + '<div class="post-body">' + this.text + '<div class="bottom_fade"></div></div> <a href="#" onclick="event.preventDefault(); readMore(' + this.id + ')" class="post-link">Read More...</a></div>');
  });
});

function readMore(id) {
  $.getJSON('http://benji.herokuapp.com/api/articles/' + id, function(data) {
    var article = data.article;
    $('.container').addClass('blur-background');
    $('body').append('<div class="overlay"><a href="#" class="close-button" onclick="event.preventDefault(); closePost(' + id +')" ">&#10006; <span>CLOSE</span></a><h3 class="post-title">' + article.title + '</h3>' + article.text + '</div>').fadeIn(900);
  });
};

function closePost(id) {
  $('.container').removeClass('blur-background');
  $('.overlay').remove();
};



