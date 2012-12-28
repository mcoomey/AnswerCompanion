# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# set up autocomplete options for subject category and subcategory text_fields
jQuery ->
	$("#subject_subcategory_name").autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#subject_subcategory_name").data("autocomplete-source")

	$("#subject_category_name").autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#subject_category_name").data("autocomplete-source")
	  select: (event, ui) ->
	    subcatSub = $("#subject_subcategory_name").data("autocomplete-source").replace(/\=.*/, "=" + ui.item.value)
	    $("#subject_subcategory_name").autocomplete "option", "source", subcatSub
	  change: (event, ui) ->
		  $("#subject_subcategory_name").val("")
