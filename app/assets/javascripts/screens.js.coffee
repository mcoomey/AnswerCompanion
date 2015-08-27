# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
# function to cancel out of a login and restore the screen index(i.e. the home page)
  $(".cancel-login").click ->
    $("#login-register").hide()
    $("#videoblock").show()
    $("#menu").show()
    $(".alert").empty()
    $(".notice").empty()
    $(".ujs_alert").empty()
    $(".ujs_notice").empty()
  