# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@VideoPoller =
  request: ->
    if $(".video_processing").length > 0
      $(".video_processing").each (index) ->
        id = undefined
        old_version_id = undefined
        videofile_processed = undefined
        new_version_url = @dataset.url
        $.getJSON @dataset.url, (data) ->
          $.each data, (k, v) ->
            # console.log "k=" + k + "   v=" + v
            if k == "id"
              id = v
            if k == "old_version_id"
              old_version_id = v
            if k == "videofile_processed"
              videofile_processed = v
              
          if videofile_processed == 1
            # console.log "video(" + id+ ")" + "has finished processing."
            
            # change the wait spinner icon to play icon 
            $("#video_processing_"+id).removeClass("video_processing").addClass("video_hide_icon")
            $("#video_processed_"+id).removeClass("video_hide_icon")
            $("#processing_error_"+id).addClass("video_hide_icon")
            $("#messages span.ujs_notice").html("")
            
            # fix the html so that the old_version_id is reflected in links and id's
            re1 = new RegExp("videos/"+id, "g")
            re2 = new RegExp("video_"+id, "g")
            content = $("tr#video_id_"+id).html().replace(re1, "videos/"+old_version_id).replace(re2, "video_"+old_version_id)
            $("tr#video_id_"+id).html(content)
            
            # now remove the new record from the db as it has been copied over the old record
            $.ajax
              type: 'POST'
              url: new_version_url
              dataType: 'json'
              data: '_method': 'delete'
          
          if videofile_processed < 0
            # console.log "video(" + id +  ")" + "processing has failed."
            $("#video_processing_"+id).removeClass("video_processing").addClass("video_hide_icon")
            $("#video_processed_"+id).addClass("video_hide_icon")
            $("#processing_error_"+id).removeClass("video_hide_icon")
            $("#messages span.ujs_notice").html("")
              
      setTimeout (->
        VideoPoller.request()
      ), 5000
    
jQuery ->
  VideoPoller.request()
    