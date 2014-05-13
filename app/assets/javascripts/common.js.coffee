window.handleDropEvent = (event, ui) ->
  dragitem = ui.draggable
  model = dragitem.data("model")
  id = dragitem.data("model_id")  
  dropitem = $(this).find("a").attr("href")
  tabs = [".current-tab", ".archived-tab", ".future-tab"]
  whichTab = tabs.indexOf(dropitem)  
  secure_token = $("meta[name=\"csrf-token\"]").attr("content")
  dataString = "authenticity_token=" + secure_token + "&archived=" + whichTab + "&position=999"
  urlString = window.location.pathname + "/" + id
  
  console.log "model = " + model
  console.log "id = " + id
  console.log "whichTab = " + whichTab
  
  $.ajax
    type: "PUT"
    url: urlString
    data: dataString

  if model == "textbook_delegation"
    $("div"+tabs[whichTab]+" ul").append("<li id=\"tbdel_id_"+id+"\" class=\"frontcover\" data-model_id=\"" + id + "\" data-model=\"textbook_delegation\"" + ">"+ dragitem.html() + "</li>")
  else if model == "course"
    $("div" + tabs[whichTab] + " table tr:last").after("<tr data-model=" + model + " data-model_id=" + id + ">" + dragitem.html() + "</tr>")
  else if model == "document"
    $("div" + tabs[whichTab] + " table tr:last").after("<tr id=document_id_" + id + " data-model=" + model + " data-model_id=" + id + ">" + dragitem.html() + "</tr>")
  else if model == "textbox"
    $("div"+tabs[whichTab]+" ul").prepend("<li class=\"textbox\" data-model_id=" + id + " id= tbox_id_" + id + "> "+ dragitem.html() + "<\li>")
  else
    console.log "unhandled model type: " + model
  dragitem.remove()


window.handleSortEvent = (event, ui) ->
  data = $(this).sortable('serialize')
  urlString = window.location.pathname + "/sort" 

  $.ajax
    type: "PUT"
    url: urlString
    data: data
    
