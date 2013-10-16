jQuery.fn.setDynamicTabs = ->
  # find all the anchors within this selection
  $links = $(this).find("a")
  $links.each ->
    if $(this).attr("href") == location.pathname
      $(this).parent().addClass("activeTab")
    else
      $(this).parent().removeClass("activeTab")

  $(this).on "click", "a", (e) ->
    $("#panel").remove() unless $(this).parent().attr("class") == "activeTab"    
    $(this).parent().parent().parent().find("a").parent().removeClass("activeTab")
    $(this).parent().addClass("activeTab")