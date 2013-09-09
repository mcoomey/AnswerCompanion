# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  
  # set up the horizontal (current - archived - future) tabs
  $("#horizontal-tabs ul.static-tabs-nav").setStaticTabs()

  # set up the vertical (subject|course assets) tabs
  $("#vertical-tabs ul.static-tabs-nav").setStaticTabs()

  $(this).loadSessionTabs()
  