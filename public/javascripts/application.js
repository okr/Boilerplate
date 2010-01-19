(function($) {
	$.ajaxSetup({ 
//		beforeSend: function(xhr) {
//			xhr.setRequestHeader("Accept", "text/javascript, text/html, application/xml, text/xml, application/x-json, */*");
//			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//		},
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
    
    $('textarea.tinymce').tinymce({
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
	
	$("a.modal").fancybox({
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
        'easingChange': "easeInOutQuart"
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
	
	$('#search_form').ajaxForm( {
		target: '#search_results',
		beforeSubmit: blockUISearchForm,
		success: function(){
			$(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
			$(".table tr:even").addClass("alt");
			$('.tip').tipTip();
			if($.browser.msie) {
				return(true);
			} else {
				$("#search_menu .search_button .spyglass").corner("round 5px tl bl");
				$("#search_menu .search_button .toggle_search").corner("round 5px tr br");
				$(".search_count, #search_menu form #advanced_search fieldset .field_element").corner("round 5px");
			}
			$.unblockUI();
			$.scrollTo('#search_results', 300);
		}
	});
	
	function blockUISearchForm() {
		$('#search_results table').block({
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
	
	$("a.reset").click(function() {
		$('#search_form').clearForm();
	});

	// Change all link helpers to use ajax
	$('a.order_by, a.order_as, a.page, a.per_page').live('click', function() {
		$('#search_results table').block({
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
		$('#search_results').load(this.href);
		$('#search_results').ajaxComplete(function() {
			$(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
			$(".table tr:even").addClass("alt");
			$('.table a').tipTip();
		});
		return false;
	});
	
	$('#recent_activity .pagination a').live('click', function() {
		$('#recent_activity table').block({
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
		$('#recent_activity').load(this.href);
		$('#recent_activity').ajaxComplete(function() {
			$(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
			$(".table tr:even").addClass("alt");
			$('.table a').tipTip();
		});
		return false;
	});
	
	$('a.toggle_search').toggleSearch();

	$("a[rel=external]").attr("target", "blank");

    $("a").tipTip();
 
	$('#thumbnails div.thumb a').live('click', function() {
		var imageSource = this.href;
		var imageOriginal = this.rel;
		var imageTooltip = $(this).children("img").attr("alt");
		var imageCaption = $(this).parent().find(".thumb_caption").html();

		var largeImage = new Image();
		
		$(this).parent().parent().children("div.thumb").find("a").removeClass("active");
		
		$(this).addClass("active");

		$("#fullsize a img").remove();
		$.blockUI({ 
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
		$("#fullsize #caption").hide();
		
	    $(largeImage).load(function()
		{
			$(this).hide();
			$("#fullsize a").attr({href: imageOriginal, title: imageTooltip}).append(this);
			$("#fullsize #caption p").remove();
			$("#fullsize #caption").append(imageCaption);
			$("#fullsize a").tipTip();
			$("#fullsize a img").fadeIn("slow");
			$("#fullsize #caption").show();
			$("a[rel=modal]").fancybox({
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
		$(largeImage).attr({src: imageSource});
		return false;
	});
	
	//nested forms
	
	$(".addChild").click( function() {
		var new_id = new Date().getTime();
		var childArea = this.rel;
		$("#" + childArea).append( object.replace(/NEW_RECORD/g, new_id) );
		$("input.tags-input").autocomplete("tags");
		$.scrollTo("#" + childArea, 300);
		$("#" + childArea).children().find(".removeChild").click( function() {
			$(this).parent().parent().remove();
		});
	});
	
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