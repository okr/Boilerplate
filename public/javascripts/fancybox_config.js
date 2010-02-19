$(document).ready(function(){

    $("a.modal").fancybox({
    	'zoomSpeedIn':	300, 
    	'zoomSpeedOut': 300, 
    	'overlayShow':	true,
    	'overlayColor': '#000',
    	'overlayOpacity': .9,
    	'centerOnScroll': true,
    	'zoomOpacity': true,
        'easingIn': "easeOutBack",
        'easingOut': "easeInBack",
        'easingChange': "easeInOutQuart",
        'showCloseButton': true,
        'cyclic': true,
        'autoScale': true,
        'titlePosition': 'over',
        'transitionIn': 'elastic',
        'transitionOut': 'elastic'
    });

})