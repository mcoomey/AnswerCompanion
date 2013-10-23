# loadSessionTabs - check session cookie for previously selected static tabs and re-select
jQuery.fn.loadSessionTabs = ->
  # check session cookie for previously selected horizontal tab
  tab = $.cookie("horizontal_tabs_index")
  if tab == null
    # select the first tab on initial load
    $("#horizontal-tabs a").first().trigger('click')
  else
    # find which tab was previously selected
    numtabs = $("#horizontal-tabs a").size()
    for htab in [0..(numtabs-1)] by 1
      if $("#horizontal-tabs a")[htab].attributes[0].value == tab
        $("#horizontal-tabs a").eq(htab).trigger('click')
        break
    # if no matching tab was found default to the first one
    if htab >= numtabs
      $("#horizontal-tabs a").first().trigger('click')
      
jQuery.fn.setStaticTabs = ->
	# For each set of tabs, we want to keep track of
  # which tab is active and it's associated content
  $active = undefined
  $content = undefined
  $links = $(this).find("a")

  # If the location.hash matches one of the links, use that as the active tab.
  # If no match is found, use the first link as the initial active tab.
  $active = $($links.filter("[href=\"" + location.hash + "\"]")[0] || $links[0])
  $active.parent().addClass "activeTab"
  $content = $($active.attr("href"))

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

    # store the hash of the clicked tab and its div in the "horizontal_tabs_index" cookie
    $hash = $(this).attr("href")
    cookie_name = "horizontal_tabs_index"
    $.cookie(cookie_name, $hash, path: '/')
  
    # Make the tab active.
    $active.addClass "activeTab"
    $active.parent().addClass "activeTab"
    $content.show()
  
    # Prevent the anchor's default click action
    e.preventDefault()
