# loadSessionTabs - check session cookie for previously selected static tabs and re-select
jQuery.fn.loadSessionTabs = ->
  
  # check session cookie for previously selected horizontal tab
  tab = $.cookie("horizontal-tabs-index")
  if tab == null
    # select the first tab on initial load
    $("#horizontal-tabs a").first().trigger('click')
  else
    # find which tab was previously selected
    for htab in [0..($("#horizontal-tabs a").size()-1)] by 1
      if $("#horizontal-tabs a")[htab].attributes[0].value == tab
        $("#horizontal-tabs a").eq(htab).trigger('click')
  
  # check session cookie for previously selected vertical tab
  tab = $.cookie("vertical-tabs-index")
  if tab == null
    # select the first tab on initial load
    $("#vertical-tabs a").first().trigger('click')
  else
    # find which tab was previously selected
    for vtab in [0..($("#vertical-tabs a").size()-1)] by 1
      if $("#vertical-tabs a")[vtab].attributes[0].value == tab
        $("#vertical-tabs a").eq(vtab).trigger('click')


jQuery.fn.setStaticTabs = ->
	# For each set of tabs, we want to keep track of
  # which tab is active and it's associated content
  $active = undefined
  $content = undefined
  $links = $(this).find("a")

  # If the location.hash matches one of the links, use that as the active tab.
  # If no match is found, use the first link as the initial active tab.
  $active = $($links.filter("[href=\"" + location.hash + "\"]")[0] || $links[0])
  $active.addClass "activeTab"
  $active.parent().addClass "activeTab"
  $content = $($active.attr("href"))

  # store the hash of the addressed tab in the appropriate cookie (horizontal-tabs-index or vertical-tabs-index)
  cookie_name = $(this).closest('div').attr('id') + "-index"
  $hash = $active.attr("href")
  $.cookie(cookie_name, $hash, path: '/')

  # Hide the remaining content
  $links.not($active).each ->
    $($(this).attr("href")).hide()


  # Bind the click event handler
  $(this).on "click", "a", (e) ->
  
    # Make the old tab inactive.
    $active.removeClass "activeTab"
    $active.parent().removeClass "activeTab"
    $content.hide()
  
    # Update the variables with the new link and content
    $active = $(this)
    $content = $($(this).attr("href"))

    # store the hash of the clicked tab and its div in the "xxxx-tabs-index" cookie
    $hash = $(this).attr("href")
    cookie_name = $(this).closest('div').attr('id') + "-index"
    
    $.cookie(cookie_name, $hash, path: '/')
  
    # Make the tab active.
    $active.addClass "activeTab"
    $active.parent().addClass "activeTab"
    $content.show()
  
    # Prevent the anchor's default click action
    e.preventDefault()
