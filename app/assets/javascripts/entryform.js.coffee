# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('div').find('input:hidden').val('1')
    $(this).closest('div').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->  
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    fields = $(this).prev().find('input')
    fields.eq(0).autocomplete
  	  minLength: 0
  	  delay: 0
  	  source: fields.eq(0).data("autocomplete-source"),
      messages: {noResults: '', results: ''}
      select: (event, ui) ->
        info = ui.item.value.split("||")
        ui.item.value = info[0]
        fields.eq(0).val info[0]
        fields.eq(1).val info[1]
        fields.eq(2).val info[2]
    event.preventDefault()
    