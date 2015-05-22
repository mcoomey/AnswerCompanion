window.handleDropEvent = (event, ui) ->
  $("#ujsform").remove()
  $("#buttonarea").show()
  dragitem = ui.draggable
  model = dragitem.data("model")
  id = dragitem.data("model_id")  
  dropitem = $(this).find("a").attr("href")
  tabs = [".current-tab", ".archived-tab", ".future-tab"]
  whichTab = tabs.indexOf(dropitem)  
  $.cookie("dropTab", dropitem, path: '/')
  secure_token = $("meta[name=\"csrf-token\"]").attr("content")
  dataString = "authenticity_token=" + secure_token + "&archived=" + whichTab
  urlString = window.location.pathname + "/" + id
  console.log "urlString = " + urlString 
  console.log "dataString = " + dataString 
  console.log "whichTab = " + whichTab
  console.log "dragitem.html() = " + dragitem.html()
  for key of ui
    console.log "key = " + key + "  value = " + ui[key]
    # if key == "helper"
    #   subobj = ui[key]
    #   for key2 of subobj
    #     console.log "    key2 = " + key2 + "  value = " + subobj[key2]
  #     subsub = subobj[key2]
  #     for key3 of subsub
  #       console.log "        key3 = " + key3
  #
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
  dataString = $(this).sortable('serialize')
  urlString = window.location.pathname + "/sort" 
  console.log "urlString = " + urlString 
  console.log "dataString = " + dataString 

  $.ajax
    type: "PUT"
    url: urlString
    data: dataString
    
window.handleVerticalSortEvent = (event, ui) ->
  dataString = $(this).sortable('serialize')
  urlString = "/course_assets/sort" 
  console.log "urlString = " + urlString 
  console.log "dataString = " + dataString 

  $.ajax
    type: "PUT"
    url: urlString
    data: dataString
    
window.ujsMessages = (ujsAlert, ujsNotice) ->
  $("#messages .ujs_alert").html ujsAlert
  $("#messages .ujs_notice").html ujsNotice
  
window.onpopstate = (event) ->
  console.log "on popstate: " + JSON.stringify(event.state)
  location.reload()
    