jQuery ->
	$("ul.static-tabs-nav").each ->
  
	  # For each set of tabs, we want to keep track of
	  # which tab is active and it's associated content
	  $active = undefined
	  $content = undefined
	  $links = $(this).find("a")
  
	  # If the location.hash matches one of the links, use that as the active tab.
	  # If no match is found, use the first link as the initial active tab.
	  $active = $($links.filter("[href=\"" + location.hash + "\"]")[0] or $links[0])
	  $active.addClass "activeTab"
	  $active.parent().addClass "activeTab"
	  $content = $($active.attr("href"))

	  # store the hash of the addressed tab in the "course_index_tab" cookie
	  $hash = $active.attr("href")
	  $.cookie('index_tab', $hash)
  
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

	    # store the hash of the clicked tab in the "index_tab" cookie
	    $hash = $(this).attr("href")
	    $.cookie('index_tab', $hash)
    
	    # Make the tab active.
	    $active.addClass "activeTab"
	    $active.parent().addClass "activeTab"
	    $content.show()
    
	    # Prevent the anchor's default click action
	    e.preventDefault()

