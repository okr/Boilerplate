(function($) {
	$.ajaxSetup({ 
		beforeSend: function(xhr) {
			xhr.setRequestHeader("Accept", "text/javascript, text/html, application/xml, text/xml, application/x-json, */*");
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		},
		success: function(response, status){
			$.unblockUI();
		}
	});

	$().ajaxSend(function(event, request, settings) {
		if (typeof(AUTH_TOKEN) == "undefined") return;
		settings.data = settings.data || "";
		settings.data += ((settings.data == "") ? "" : "&") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
	});
})(jQuery);

$.fn.submitWithAjax = function() {
	this.submit(function() {
		$.post(
			$(this).attr("action"),
			$(this).serialize(),
			null,
			"script"
		);
		return false;
	})
	return this;
};

$.fn.toggleSearch = function() {
	this.click(function() {
		$('#advanced_search').toggle("blind");
		var $this = $("a.toggle_search").parent("li");
		if($(this).is(".active")){
			$(this).removeClass("active")
		}
		else {
			$(this).addClass("active");
		}
		return false;
	});
}

$(document).ready(function(){

    $("a.crop").fancybox({
        'zoomSpeedIn':  0, 
        'zoomSpeedOut': 0, 
        'overlayShow':  true,
        'overlayOpacity': .8,
        'centerOnScroll': true,
        'hideOnContentClick': false,
        'hideOnOverlayClick': false,
        'overlayColor': '#000',
        'overlayOpacity': .9,
        'frameWidth': 600,
        'frameHeight': 600,
        'easingIn': "easeOutBack",
        'easingOut': "easeInBack",
        'easingChange': "easeInOutQuart",
        'autoDimensions': true
    });

	$("a.toplink").click(function(){ 
		$.scrollTo('#header', 300);
	});
	
	$(".toggler").click(function () {
        $(this).next(".fieldset_toggle").toggle();
    });
	
	//initialize datepicker
    $('.event_date').datepicker();

	$('#sidebar_nav.accordion').accordion({
		active: 'li.toggle.active',
		selectedClass: 'selected',
		alwaysOpen: false,
		header: "li a.header",
		clearStyle: true,
		autoHeight: false,
		icons: { 'header': 'ui-icon-closed', 'headerSelected': 'ui-icon-open' },
		animated: false
	});
	
	$('#sidebar .pagination a').live('click', function() {
		$('#sidebar ul').block({
			message: '<p><img src="/images/icons/loader.gif" /><br /><br />Loading, Please Wait</p>',
			css: {
				border: 'none', 
				padding: '15px', 
				backgroundColor: '#FFF',
				'-webkit-border-radius': '10px', 
				'-moz-border-radius': '10px',
				color: '#000'
			}
		});
		$('#sidebar').load(this.href);
		return false;
	});
	
	$("#sidebar_nav.standard li:odd, #sidebar_nav.accordion li.toggle:odd, .submenu li:odd, ul.standard li:odd").addClass("odd");
	
	$('#content_right ul.accordion').accordion({
		active: "#form_checklist.accordion li.active",
		alwaysOpen: false,
		header: "li a.header",
		clearStyle: true,
		autoHeight: false,
		selectedClass: 'li.toggle a.header.selected',
		icons: { 'header': 'ui-icon-closed', 'headerSelected': 'ui-icon-open' }
	});
	
	$(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
	$(".table tr:even").addClass("alt");
	$(".table td").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
	$(".table td:even").addClass("alt");

	$("a[rel=external]").attr("target", "blank");

    $("a").tipTip();
	
	//rounded corners
	
	if($.browser.msie) {
		return(true);
	} else {
		$("#sub_nav ul li a").corner("round 10px");
		$(".submit input").corner("round 5px");
		$(".submit button").corner("round 5px");
		$(".submit a").corner("round 5px");
		$("#login_form").corner("round 10px");
		$("#search_menu .search_button .spyglass").corner("round 5px tl bl");
		$("#search_menu .search_button .toggle_search").corner("round 5px tr br");
		$(".search_count, #search_menu form #advanced_search fieldset .field_element").corner("round 5px");
		$(".actions_left").corner("round 7px tl bl");
		$(".actions_right").corner("round 7px tr br");
		$("#timeline_event").corner("round 3px");
		$("#main_menu ul li.current").corner("round 10px top");
	    $("#footer").corner("round 10px bottom");
	}
})