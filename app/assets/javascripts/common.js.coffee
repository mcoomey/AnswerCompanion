window.handleDropEvent = (event, ui) ->
  dragitem = ui.draggable
  model = dragitem.data("model")
  id = dragitem.data("model_id")  
  dropitem = $(this).find("a").attr("href")
  tabs = [".current-tab", ".archived-tab", ".future-tab"]
  whichTab = tabs.indexOf(dropitem)

  console.log ">>>>>>>>>>>>>>DROPPPED<<<<<<<<<<<<<<<<<"
  console.log "model = " + model
  console.log "id  = " + id 
  console.log "dropitem = " + dropitem  
  console.log "whichTab = " + whichTab
  console.log "window.location.pathname = " + window.location.pathname
  
  if model == "textbook_delegation"
    secure_token = $("meta[name=\"csrf-token\"]").attr("content")
    dataString = "authenticity_token=" + secure_token + "&tbdel[archive]=" + whichTab 
    urlString = window.location.pathname + "/" + id
    $.ajax
      type: "PUT"
      url: urlString
      data: dataString
    
    $("div"+tabs[whichTab]+" ul").append("<li id=\"tbdel_id_"+id+"\" class=\"frontcover\" data-model_id=\"" + id + "\" data-model=\"textbook_delegation\"" + ">"+ dragitem.html() + "</li>");
  else
    $("div" + tabs[whichTab] + " table tr:last").after("<tr data-model=" + model + " data-model_id=" + id + ">" + dragitem.html() + "</tr>")
    # $("div" + tabs[whichTab] + " table tr:last").append(ui.draggable)
  dragitem.remove()


window.handleSortEvent = (event, ui) ->
  data = $(this).sortable('serialize')
  console.log "data = " + data
  urlString = window.location.pathname + "/sort" 
  $.ajax
    type: "PUT"
    url: urlString
    data: data
    
