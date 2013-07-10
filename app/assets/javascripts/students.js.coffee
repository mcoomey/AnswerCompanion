# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#xstudent_school_name').autocomplete
    minLength: 0
    delay: 0
    source: $("#student_school_name").data("autocomplete-source"),
    messages: {noResults: '', results: ''}
    select: (event, ui) ->
      info = ui.item.value.split("||")
      ui.item.value = info[0]
      $("#student_school_name").val info[0]
      $("#student_school_town").val info[1]
      $("#student_school_state").val info[2]
