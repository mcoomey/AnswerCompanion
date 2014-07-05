jQuery.fn.setDynamicTabs = ->
  # find all the anchors within this selection
  $links = $(this).find("a")
  $links.each ->
    $href = $(this).attr("href")
    $loca = location.pathname
    
    # if $(this).attr("href") == location.pathname
    if $loca.indexOf($href) > -1
      $(this).parent().addClass("activeTab")
    else
      $(this).parent().removeClass("activeTab")

  $(this).on "click", "a", (e) ->
    $("#scroll-panel, #no-scroll-panel").remove() unless $(this).parent().attr("class") == "activeTab"    
    $(this).parent().parent().parent().find("a").parent().removeClass("activeTab")
    $(this).parent().addClass("activeTab")