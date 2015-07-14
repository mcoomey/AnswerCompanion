# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#instructor_school_name').autocomplete
	  minLength: 0
	  delay: 0
	  source: $("#instructor_school_name").data("autocomplete-source"),
    messages: {noResults: '', results: ''}
    select: (event, ui) ->
      info = ui.item.value.split("||")
      ui.item.value = info[0]
      $("#instructor_school_name").val info[0]
      $("#instructor_school_town").val info[1]
      $("#instructor_school_state_abbrev").val info[2]
