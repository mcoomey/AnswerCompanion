# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# set up autocomplete options for subject category and subcategory text_fields
jQuery ->
	$('.edit_subject').submitOnCheck()

	$("#subject_category_name").autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#subject_category_name").data("autocomplete-source"),
    messages: {noResults: '', results: ''}
