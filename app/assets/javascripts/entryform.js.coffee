jQuery.fn.toggleLabel = ->
  input = undefined
  input = $(this)
  setTimeout (->
    def = undefined
    dummy = undefined
    def = input.attr("title")
    if not input.val() or (input.val() is def)
      input.prev("span").css "visibility", ""
      if def
        dummy = $("<label></label>").text(def).css("visibility", "hidden").appendTo("body")
        input.prev("span").css "margin-left", dummy.width() + 3 + "px"
        dummy.remove()
    else
      input.prev("span").css "visibility", "hidden"
  ), 0
# 
# jQuery.fn.resetField = ->
#   def = undefined
#   def = $(this).attr("title")
#   if not $(this).val() or ($(this).val() is def)
#     $(this).val def
#     $(this).prev("span").css "visibility", ""

jQuery ->
  # document.forms[0].reset()
  $(document).on "keydown", "input, textarea", ->
    $(this).toggleLabel()

  $(document).on "paste", "input, textarea", ->
    $(this).toggleLabel()

  $(document).on "change", "select", ->
    $(this).toggleLabel()

  $(document).on "focusin", "input, textarea", ->
    $(this).prev("span").css "color", "#eeeeee"

  $(document).on "focusout", "input, textarea", ->
    $(this).prev("span").css "color", "#999999"
    
  $(window).load ->
    setTimeout (->
      $('input, textarea').each ->
        toggleLabel.call this
        ), 0
        

