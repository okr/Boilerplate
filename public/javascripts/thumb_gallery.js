$(document).ready(function(){

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
	
})