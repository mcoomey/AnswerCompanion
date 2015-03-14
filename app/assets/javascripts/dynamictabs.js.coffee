jQuery.fn.setDynamicTabs = ->
  # find all the anchors within this selection
  $links = $(this).find("a.link_to_asset")
  $links.each ->
    $href = location.origin + $(this).attr("href").split('?')[0]
    $loca = location.href.split('?')[0]
    
    if $loca.indexOf($href) > -1
      $(this).parent().addClass("activeTab")
    else
      $(this).parent().removeClass("activeTab")

  $(this).on "click", "a.link_to_asset", (e) ->
    $("#scroll-panel, #noscroll-panel").remove() unless $(this).parent().attr("class") == "activeTab"    
    $(this).parent().parent().parent().parent().parent().find("a").parent().removeClass("activeTab")
    $(this).parent().addClass("activeTab")
