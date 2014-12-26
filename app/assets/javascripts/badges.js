$(document).ready(function() {
  var user = "benjamindalton"; /* treehouse username*/
  var num = 120; /* number of badges to display, starting w/ most recent */
  $.getJSON("http://teamtreehouse.com/" + user + ".json", function(data) {
    var output = "<ul>";
    /* array starts from 0, so you access the 10th element at position 9, add 1 to stop to account for the array starting from 0 */
    var i = data.badges.length - 1;
    var stop = data.badges.length - (num + 1);
    for(i; i > stop; i--){
      output += '<li>';
      output += '<img src ="' + data.badges[i].icon_url + '" / class="grow">';
      output += '<span class = "tooltip">' + data.badges[i].name  +  '</span>';
      output += "</li>";
    }
    output += "</ul>";
    document.getElementById("badges").innerHTML = output;
  });
});