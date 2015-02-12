// Toggle main sections
$(".docs-sidebar-section-title").click(function () {
    $('.docs-sidebar-section').not(this).closest('.docs-sidebar-section').removeClass('active');
    $(this).closest('.docs-sidebar-section').toggleClass('active');
    event.preventDefault();
});

// Toggle 1st sub-sections
$(".docs-sidebar-section ol lh").click(function () {
    $('.docs-sidebar-section ol').not(this).closest('.docs-sidebar-section ol').removeClass('active');
    $(this).closest('.docs-sidebar-section ol').toggleClass('active');
    if ($('.docs-has-sub').hasClass('active')) {
      $(this).closest('.docs-sidebar-section ol li').addClass('open');
    }
    event.preventDefault();
});

// Toggle 2nd sub-sections
$(".docs-sidebar-section ol > li > a").click(function () {
    $('.docs-sidebar-section ol li').not(this).removeClass('active').removeClass('open');
    $(this).closest('.docs-sidebar-section ol li').toggleClass('active');
    if ($('.docs-has-sub').hasClass('active')) {
      $(this).closest('.docs-sidebar-section ol li').addClass('open');
    }
    event.preventDefault();
});

$('ol > li:has(ul)').addClass('docs-has-sub');

// Needed for code and pre
$(function() {
    var pre = document.getElementsByTagName('pre'),
        pl = pre.length;
    for (var i = 0; i < pl; i++) {
        pre[i].innerHTML = '<span class="line-number"></span>' + pre[i].innerHTML + '<span class="cl"></span>';
        var num = pre[i].innerHTML.split(/\n/).length;
        for (var j = 0; j < num; j++) {
            var line_num = pre[i].getElementsByTagName('span')[0];
            line_num.innerHTML += '<span aria-hidden="true">' + (j + 1) + '</span>';
        }
    }
});

// webui popover
$(document).ready(function() {
    function checkWidth() {
        var windowSize = $(window).width();

        if (windowSize <= 767) {
            $('.gloss').webuiPopover({placement:'auto',trigger:'click'});
        }
        else if (windowSize >= 768) {
            $('.gloss').webuiPopover({placement:'auto',trigger:'hover'});
        }
    }

    // Execute on load
    checkWidth();
    // Bind event listener
    $(window).resize(checkWidth);
});

// Bootstrap stuff
$('.docs-actions i').tooltip();
$('.docs-sidebar-home').tooltip();

// Hide/Toggle definitions
$("#toggle-definitions").click(function () {
  $(this).toggleClass('docs-info-off');
  if ($('.gloss').hasClass('on')) {
      $('.gloss').removeClass('on').addClass('off').webuiPopover('destroy');
  } else if ($('.gloss').hasClass('off')) {
      $('.gloss').removeClass('off').addClass('on').webuiPopover();
  }
});

// Smooth scroll
$('a').click(function(){
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top
    }, 500);
    return false;
});






