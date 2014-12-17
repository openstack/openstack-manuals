// Open header search bar
$(function() {
  $(".search-icon").click(function() {
    $(".navbar-main").toggleClass("show");
    $(".search-container").toggleClass("show");
    $(".search-icon").toggleClass("show");
    $('#gsc-i-id1').focus();
  });
});

// Close header search bar
$(function() {
  $(".close-search").click(function() {
    $(".navbar-main").toggleClass("show");
    $(".search-container").toggleClass("show")
    $(".search-icon").toggleClass("show");
  });
});

// Open header drop downs on hover
jQuery(document).ready(function(){
    if (jQuery(window).width() > 767) {
        $('ul.navbar-main li ul.dropdown-menu').addClass('dropdown-hover');
        $('ul.navbar-main li').hover(function() {
          $(this).find('.dropdown-hover').stop(true, true).delay(400).fadeIn(100);
      }, function() {
          $(this).find('.dropdown-hover').stop(true, true).delay(100).fadeOut(200);
      });
    } else {
        $('ul.navbar-main li ul.dropdown-menu').removeClass('dropdown-hover');
    }
});
jQuery(window).resize(function () {
    if (jQuery(window).width() > 767) {
        $('ul.navbar-main li ul.dropdown-menu').addClass('dropdown-hover');
        $('ul.navbar-main li').hover(function() {
          $(this).find('.dropdown-hover').stop(true, true).delay(400).fadeIn(100);
      }, function() {
          $(this).find('.dropdown-hover').stop(true, true).delay(100).fadeOut(200);
      });
    } else {
        $('ul.navbar-main li ul.dropdown-menu').removeClass('dropdown-hover');
    }
});

// Remove Search text in smaller browser windows
jQuery(document).ready(function(){
    if (jQuery(window).width() < 1050) {
        $('#search-label').text('');
    } else {
        $('#search-label').text('Search');
    }
});
jQuery(window).resize(function () {
    if (jQuery(window).width() < 1050) {
        $('#search-label').text('');
    } else {
        $('#search-label').text('Search');
    }
});

// Show placeholder text in Google Search
setTimeout( function() {
    $(".gsc-input").attr("placeholder", "search openstack");
}, 1000 );


