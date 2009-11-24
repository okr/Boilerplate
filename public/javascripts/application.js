jQuery.noConflict();

(function($) {
	jQuery.ajaxSetup({ 
		beforeSend: function(xhr) {
			xhr.setRequestHeader("Accept", "text/javascript, text/html, application/xml, text/xml, application/x-json, */*");
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		},
		success: function(response, status){
			jQuery.unblockUI();
		}
	});

	jQuery().ajaxSend(function(event, request, settings) {
		if (typeof(AUTH_TOKEN) == "undefined") return;
		settings.data = settings.data || "";
		settings.data += ((settings.data == "") ? "" : "&") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
	});
})(jQuery);

jQuery.fn.submitWithAjax = function() {
	this.submit(function() {
		jQuery.post(
			jQuery(this).attr("action"),
			jQuery(this).serialize(),
			null,
			"script"
		);
		return false;
	})
	return this;
};

jQuery.fn.toggleSearch = function() {
	this.click(function() {
		jQuery('#advanced_search').toggle("blind");
		var $this = $("a.toggle_search").parent("li");
		if(jQuery(this).is(".active")){
			jQuery(this).removeClass("active")
		}
		else {
			jQuery(this).addClass("active");
		}
		return false;
	});
}

jQuery(document).ready(function(){
    
    jQuery('textarea.tinymce').tinymce({
        script_url : '/javascripts/tiny_mce/tiny_mce.js',
        mode : "textareas",
    	theme : "advanced",
    	editor_selector : "rich_text_editor",
    	editor_deselector : "mceNoEditor",
    	valid_elements :"" +
    					"strong," +
    					"em," +
    					"p[style]," +
    					"a[href|rel]",
    	verify_html : true,
    	plugins : "safari,pagebreak,save,advlink,inlinepopups,insertdatetime,searchreplace,print,paste,directionality,noneditable",

    	// Theme options
    	theme_advanced_buttons1 : "bold,italic,|,link,unlink,image,|,bullist,numlist,|,justifyleft,justifycenter,justifyright,|,search,replace,spellchecker,|,code,cleanup,removeformat,undo,redo,|,cut,copy,paste,pastetext,pasteword,",
    	theme_advanced_buttons2 : "",
    	theme_advanced_buttons3 : "",
    	theme_advanced_toolbar_location : "top",
    	theme_advanced_toolbar_align : "center",
    	theme_advanced_statusbar_location : "none",
    	theme_advanced_path : false,
    	width : "100%",
    	height : "200px",
    	remove_trailing_nbsp : true,
    	cleanup_on_startup : true,
    	cleanup : true,
    	dialog_type : "modal",
    	theme_advanced_resizing : false,

    	//plugin options
    	paste_remove_styles : true,
    	paste_auto_cleanup_on_paste : true,
    	paste_convert_headers_to_strong : true,
    	paste_create_paragraphs : true,
    	paste_create_linebreaks : false,
    	paste_strip_class_attributes : "all"
    });
	
	jQuery("a.modal").fancybox({
		'zoomSpeedIn':	300, 
		'zoomSpeedOut': 300, 
		'overlayShow':	true,
		'imageScale': true,
		'overlayOpacity': .5,
		'centerOnScroll': true,
		'zoomOpacity': true,
        'easingIn': "easeOutBack",
        'easingOut': "easeInBack",
        'easingChange': "easeInOutQuart"
	});
	
    jQuery("a.crop").fancybox({
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
        'easingChange': "easeInOutQuart"
    });

	setTimeout(hideFlashes, 2000);

	jQuery("a.toplink").click(function(){ 
		$.scrollTo('#header', 300);
	});
	
	jQuery(".toggler").click(function () {
        jQuery(this).next(".box_toggle").toggle();
    });
	
	//initialize datepicker
    jQuery('.event_date').datepicker();

	jQuery('#sidebar_nav.accordion').accordion({
		active: 'li.toggle.active',
		selectedClass: 'selected',
		alwaysOpen: false,
		header: "li a.header",
		clearStyle: true,
		autoHeight: false,
		icons: { 'header': 'ui-icon-closed', 'headerSelected': 'ui-icon-open' },
		animated: false
	});
	
	jQuery('#sidebar .pagination a').live('click', function() {
		jQuery('#sidebar ul').block({
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
		jQuery('#sidebar').load(this.href);
		return false;
	});
	
	jQuery("#sidebar_nav.standard li:odd, #sidebar_nav.accordion li.toggle:odd, .submenu li:odd, ul.standard li:odd").addClass("odd");
	
	jQuery('#content_right ul.accordion').accordion({
		active: "#form_checklist.accordion li.active",
		alwaysOpen: false,
		header: "li a.header",
		clearStyle: true,
		autoHeight: false,
		selectedClass: 'li.toggle a.header.selected',
		icons: { 'header': 'ui-icon-closed', 'headerSelected': 'ui-icon-open' }
	});
	
	jQuery(".table tr").mouseover(function(){jQuery(this).addClass("over");}).mouseout(function(){jQuery(this).removeClass("over");});
	jQuery(".table tr:even").addClass("alt");
	jQuery(".table td").mouseover(function(){jQuery(this).addClass("over");}).mouseout(function(){jQuery(this).removeClass("over");});
	jQuery(".table td:even").addClass("alt");
	
	jQuery('#search_form').ajaxForm( {
		target: '#search_results',
		beforeSubmit: blockUISearchForm,
		success: function(){
			jQuery(".table tr").mouseover(function(){jQuery(this).addClass("over");}).mouseout(function(){jQuery(this).removeClass("over");});
			jQuery(".table tr:even").addClass("alt");
			jQuery('.tip').tooltip({
				track: true,
				delay: 0,
				showURL: false,
				showBody: " - "
			});
			if(jQuery.browser.msie) {
				return(true);
			} else {
				jQuery("#search_menu .search_button .spyglass").corners("5px transparent top-left 5px transparent bottom-left")
				jQuery("#search_menu .search_button .toggle_search").corners("5px transparent top-right 5px transparent bottom-right")
				jQuery(".search_count, #search_menu form #advanced_search fieldset .field_element").corners("5px transparent");
			}
			jQuery.unblockUI();
			jQuery.scrollTo('#search_results', 300);
		}
	});
	
	function blockUISearchForm() {
		jQuery('#search_results table').block({
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
	}
	
	jQuery("a.reset").click(function() {
		jQuery('#search_form').clearForm();
	});

	// Change all link helpers to use ajax
	jQuery('a.order_by, a.order_as, a.page, a.per_page').live('click', function() {
		jQuery('#search_results table').block({
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
		jQuery('#search_results').load(this.href);
		jQuery('#search_results').ajaxComplete(function() {
			jQuery(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
			jQuery(".table tr:even").addClass("alt");
			jQuery('.table a').tooltip({
				track: true,
				delay: 0,
				showURL: false,
				showBody: " - ",
				fixPNG: true,
				fade: 300
			});
		});
		return false;
	});
	
	jQuery('#recent_activity .pagination a').live('click', function() {
		jQuery('#recent_activity table').block({
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
		jQuery('#recent_activity').load(this.href);
		jQuery('#recent_activity').ajaxComplete(function() {
			$(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
			jQuery(".table tr:even").addClass("alt");
			jQuery('.table a').tooltip({
				track: true,
				delay: 0,
				showURL: false,
				showBody: " - ",
				fixPNG: true,
				fade: 300
			});
		});
		return false;
	});
	
	jQuery('a.toggle_search').toggleSearch();
	
    // jQuery.ifixpng('/images/pixel.gif');

	jQuery("a[rel=external]").attr("target", "blank");
	
    jQuery("a").tooltip({
      effect: 'fade',
      delay: 0,
      opacity: .7,
      position: 'bottom center',
      offset: [10, -20],
      relative: true,
      cancelDefault: false
     });
 
	jQuery('#thumbnails div.thumb a').live('click', function() {
		var imageSource = this.href;
		var imageOriginal = this.rel;
		var imageTooltip = $(this).children("img").attr("alt");
		var imageCaption = $(this).parent().find(".thumb_caption").html();

		var largeImage = new Image();
		
		jQuery(this).parent().parent().children("div.thumb").find("a").removeClass("active");
		
		jQuery(this).addClass("active");

		jQuery("#fullsize a img").remove();
		jQuery.blockUI({ 
			message: '<p>Loading, Please Wait</p>',
			css: { 
				border: 'none', 
				padding: '15px', 
				backgroundColor: '#000',
				'-webkit-border-radius': '10px', 
				'-moz-border-radius': '10px', 
				opacity: '.5', 
				color: '#fff' 
			}
		});
		jQuery("#fullsize #caption").hide();
		
	    jQuery(largeImage).load(function()
		{
			jQuery(this).hide();
			jQuery("#fullsize a").attr({href: imageOriginal, title: imageTooltip}).append(this);
			jQuery("#fullsize #caption p").remove();
			jQuery("#fullsize #caption").append(imageCaption);
			jQuery("#fullsize a").tooltip({
				track: true,
				delay: 0,
				showURL: false,
				showBody: " - ",
				fixPNG: true,
				fade: 300
			});
			jQuery("#fullsize a img").fadeIn("slow");
			jQuery("#fullsize #caption").show();
			jQuery("a[rel=modal]").fancybox({
				'zoomSpeedIn':	300, 
				'zoomSpeedOut': 300, 
				'overlayShow':	true,
				'imageScale': true,
				'overlayOpacity': .8,
				'centerOnScroll': true,
				'zoomOpacity': true
			});
			$.unblockUI();
		});
		jQuery(largeImage).attr({src: imageSource});
		return false;
	});
	
	//nested forms
	
	jQuery(".addChild").click( function() {
		var new_id = new Date().getTime();
		var childArea = this.rel;
		jQuery("#" + childArea).append( object.replace(/NEW_RECORD/g, new_id) );
		jQuery("#" + childArea).children().find(".removeChild").click( function() {
			jQuery(this).parent().parent().remove();
		});
	});
	
	//rounded corners
	
	if(jQuery.browser.msie) {
		return(true);
	} else {
		jQuery("#sub_nav ul li a").corner("round 10px");
		jQuery("#login_form").corner("round 10px");
		jQuery("#search_menu .search_button .spyglass").corner("round 5px tl bl");
		jQuery("#search_menu .search_button .toggle_search").corner("round 5px tr br");
		jQuery(".search_count, #search_menu form #advanced_search fieldset .field_element").corner("round 5px");
		jQuery(".actions_left").corner("round 7px tl bl");
		jQuery(".actions_right").corner("round 7px tr br");
		jQuery("#timeline_event").corner("round 3px");
		jQuery("#main_menu ul li.current").corner("round 10px top");
	    jQuery("#footer").corner("round 10px bottom");
	}
})

var hideFlashes = function() {
	jQuery('p.notice, p.warning, p.error, p.alert').hide("slide", { direction: "up" }, 600);
}