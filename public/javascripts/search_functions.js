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

    $('a.toggle_search').toggleSearch();
    
    $('#search_form').live('submit', function() {
        $(this).ajaxSubmit( {
    		beforeSubmit: blockUIAjax('#search_results'),
    		success: function(){
    			setupSearchTable('#search_results');
    			$.unblockUI();
    			$.scrollTo('#search_results', 300);
    		}
    	});
    	return false;
	});
	
	$("a.reset").click(function() {
		$('#search_form').clearForm();
	});

	// Change all link helpers to use ajax
	$('a.order_by, a.order_as, a.page, a.per_page').live('click', function() {
		blockUIAjax('#search_results');
		$('#search_results').load(this.href);
		$('#search_results').ajaxComplete(function() {
			setupSearchTable('#search_results');
			$.unblockUI();
		});
		return false;
	});
	
	$('#recent_activity .pagination a').live('click', function() {
        blockUIAjax('#recent_activity table');
		$.get(this.href);
		$('#recent_activity').ajaxComplete(function() {
			setupSearchTable('#recent_activity');
			$.unblockUI();
		});
		return false;
	});
	
	function blockUIAjax(element) {
		$(element).block({
			message: '<p><img src="/images/icons/loader.gif" /><br /><br />Loading, Please Wait</p>',
			css: {
				border: 'none', 
				padding: '5px', 
				backgroundColor: '#FFF',
				'-webkit-border-radius': '5px', 
				'-moz-border-radius': '5px',
				color: '#000'
			}
		});
		return false;
	}
	
	function setupSearchTable(element) {
	    $(".table tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});
	    $(".table tr:even").addClass("alt");
	    $('.tip').tipTip();
	    $('a.toggle_search').toggleSearch();
	    if($.browser.msie) {
	    	return(true);
	    } else {
	    	$("#search_menu .search_button .spyglass").corner("round 5px tl bl");
	    	$("#search_menu .search_button .toggle_search").corner("round 5px tr br");
	    	$(".search_count, #search_menu form #advanced_search fieldset .field_element").corner("round 5px");
	    	$(".submit input, .submit button, .submit a").corner("round 5px");
	    }
	    $.unblockUI();
	    $.scrollTo(element, 300);
	    return false;
	}

})