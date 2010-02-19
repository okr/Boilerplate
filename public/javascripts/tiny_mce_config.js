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

})