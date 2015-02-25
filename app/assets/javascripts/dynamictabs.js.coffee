jQuery.fn.setDynamicTabs = ->
  # find all the anchors within this selection
  $links = $(this).find("a.link_to_asset")
  $links.each ->
    $href = $(this).attr("href")
    $loca = location.pathname
    
    # if $(this).attr("href") == location.pathname
    if $href.indexOf($loca) > -1
      $(this).parent().addClass("activeTab")
    else
      $(this).parent().removeClass("activeTab")

  $(this).on "click", "a.link_to_asset", (e) ->
    $("#scroll-panel, #no-scroll-panel").remove() unless $(this).parent().attr("class") == "activeTab"    
    $(this).parent().parent().parent().parent().parent().find("a").parent().removeClass("activeTab")
    $(this).parent().addClass("activeTab")
