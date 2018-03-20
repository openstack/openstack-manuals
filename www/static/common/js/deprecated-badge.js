window.onload = function(){
    document.getElementById('deprecated-badge-close-button').onclick = function(){
        var deprecated_badge = document.getElementById('deprecated-badge');
        deprecated_badge.style.display = 'none';
    };
};