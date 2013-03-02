# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#new_video').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(wmv|mp4|webm|ogv|mov|flv)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file).trim())
        $('#new_video').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a wmv, mp4, webm, ogv, mov or flv file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $('.upload').remove()
