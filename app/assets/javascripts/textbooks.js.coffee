# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# set up autocomplete options for textbook category and subcategory text_fields
jQuery ->
	$("#textbook_subcategory_name").autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#textbook_subcategory_name").data("autocomplete-source"),
    messages: {noResults: '', results: ''}

	$("#textbook_category_name").autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#textbook_category_name").data("autocomplete-source"),
    messages: {noResults: '', results: ''}
	  select: (event, ui) ->
	    subcatSub = $("#textbook_subcategory_name").data("autocomplete-source").replace(/\=.*/, "=" + ui.item.value)
	    $("#textbook_subcategory_name").autocomplete "option", "source", subcatSub
	  change: (event, ui) ->
		  $("#textbook_subcategory_name").val("")
