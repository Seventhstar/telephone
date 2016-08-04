# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#task_client_name').autocomplete
    source: '/ajax/clients'
    select: (event, ui) ->
      $('#task_client_id').val ui.item.id
      return
    change: (event, ui) ->
      $('#task_client_id').val null
      return
  return
