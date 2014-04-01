window.handleDropEvent = (event, ui) ->
  dragitem = ui.draggable
  dropitem = $(this).find("a").attr("href")
  tbdel_id = (ui.draggable.attr("id")).substring(9)
  secure_token = $("meta[name=\"csrf-token\"]").attr("content")
  tabs = [".current-asset", ".archived-asset", ".future-asset"]
  archived = tabs.indexOf(dropitem)
  dataString = "authenticity_token=" + secure_token + "&tbdel[archive]=" + archived
  urlString = window.location.pathname + "/" + tbdel_id
  # console.log "dragitem    = " + dragitem   
  # console.log "dropitem   = " + dropitem  
  # console.log "tbdel_id  = " + tbdel_id 
  # console.log "dataString = " + dataString
  # console.log "urlString = " + urlString
  $.ajax
    type: "PUT"
    url: urlString
    data: dataString
  dragitem.insertBefore($("div"+tabs[archived]).find(".clearfloat"))
