# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

request= (x)->
  if $(".video_processing").length > 0
    $(".video_processing").each (index) ->
      id = undefined
      $.getJSON @dataset.url, (data) ->
        $.each data, (k, v) ->
          if k == "id"
            id = v
          if (k == "videofile_processed") && (v == 1)
            console.log "x=" + x + "    video(" + id+ ")" + "has finished processing."
            $("#video_processing_"+id).removeClass("video_processing").addClass("video_processed")
            $("#video_processed_"+id).removeClass("video_processed")
    setTimeout (->
      request(x+1)
    ), 5000
    
jQuery ->
  request(0)
    