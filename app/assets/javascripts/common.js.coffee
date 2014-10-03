window.handleDropEvent = (event, ui) ->
  dragitem = ui.draggable
  model = dragitem.data("model")
  id = dragitem.data("model_id")  
  dropitem = $(this).find("a").attr("href")
  tabs = [".current-tab", ".archived-tab", ".future-tab"]
  whichTab = tabs.indexOf(dropitem)  
  secure_token = $("meta[name=\"csrf-token\"]").attr("content")
  dataString = "authenticity_token=" + secure_token + "&archived=" + whichTab
  urlString = window.location.pathname + "/" + id
  console.log "urlString = " + urlString 
  console.log "dataString = " + dataString 
  $.ajax
    type: "PUT"
    url: urlString
    data: dataString

  if model == "textbook_delegation"
    $("div"+tabs[whichTab]+" ul").append("<li id=\"tbdel_id_"+id+"\" class=\"frontcover\" data-model_id=\"" + id + "\" data-model=\"textbook_delegation\"" + ">"+ dragitem.html() + "</li>")
  else if model == "textbox"
    $("div"+tabs[whichTab]+" ul").prepend("<li class=\"textbox\" data-model_id=" + id + " id= tbox_id_" + id + " data-model=" + model + "> "+ dragitem.html() + "<\li>")
  else
    $("div" + tabs[whichTab] + " table > tbody:last").append(ui.draggable.clone(true, true).show())
  dragitem.remove()


window.handleSortEvent = (event, ui) ->
  data = $(this).sortable('serialize')
  urlString = window.location.pathname + "/sort" 

  $.ajax
    type: "PUT"
    url: urlString
    data: data
    
window.handleVerticalSortEvent = (event, ui) ->
  data = $(this).sortable('serialize')
  urlString = "/course_assets/sort" 

  $.ajax
    type: "PUT"
    url: urlString
    data: data
    
