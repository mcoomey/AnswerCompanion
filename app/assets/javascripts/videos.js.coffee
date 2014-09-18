# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@VideoPoller =
  request: ->
    if $(".video_processing").length > 0
      $(".video_processing").each (index) ->
        id = undefined
        console.log "@dataset.url = " + @dataset.url
        $.getJSON @dataset.url, (data) ->
          $.each data, (k, v) ->
            console.log "k=" + k + "   v=" + v
            if k == "id"
              id = v
            if (k == "videofile_processed") && (v == 1)
              console.log "video(" + id+ ")" + "has finished processing."
              $("#video_processing_"+id).removeClass("video_processing").addClass("video_hide_icon")
              $("#video_processed_"+id).removeClass("video_hide_icon")
              $("#processing_error_"+id).addClass("video_hide_icon")
            if (k == "videofile_processed") && (v < 0)
              console.log "video(" + id +  ")" + "processing has failed."
              $("#video_processing_"+id).removeClass("video_processing").addClass("video_hide_icon")
              $("#video_processed_"+id).addClass("video_hide_icon")
              $("#processing_error_"+id).removeClass("video_hide_icon")
              
      setTimeout (->
        VideoPoller.request()
      ), 5000
    
jQuery ->
  VideoPoller.request()
    