
_gaq.push(['_trackPageview']);

var disqus_config = function ()
 {
     var config = this;
     config.callbacks.onNewComment.push (function () 
     {
         _gaq.push (['_trackEvent', 'Disqus', 'Comment', 'null', 1]);
     });
 }; 

(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

