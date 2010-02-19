$(document).ready(function(){

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

})