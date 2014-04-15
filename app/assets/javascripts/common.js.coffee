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
  
  secure_token = $("meta[name=\"csrf-token\"]").attr("content")
  dataString = "authenticity_token=" + secure_token + "&archived=" + whichTab + "&position=999"
  urlString = window.location.pathname + "/" + id
  console.log "urlString = " + urlString
  
  $.ajax
    type: "PUT"
    url: urlString
    data: dataString

  if model == "textbook_delegation"
    $("div"+tabs[whichTab]+" ul").append("<li id=\"tbdel_id_"+id+"\" class=\"frontcover\" data-model_id=\"" + id + "\" data-model=\"textbook_delegation\"" + ">"+ dragitem.html() + "</li>");
  else if model == "course"
    $("div" + tabs[whichTab] + " table tr:last").after("<tr data-model=" + model + " data-model_id=" + id + ">" + dragitem.html() + "</tr>")
  dragitem.remove()


window.handleSortEvent = (event, ui) ->
  data = $(this).sortable('serialize')
  console.log "HANDLE SORT EVENT data = " + data
  urlString = window.location.pathname + "/sort" 
  console.log "urlString = " + urlString
  $.ajax
    type: "PUT"
    url: urlString
    data: data
    
