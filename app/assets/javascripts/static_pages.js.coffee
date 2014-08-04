# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Counting and replacing number of characters in a post
$(document).ready (e) ->
  e.preventDefault
  $('#micropost_content').keyup ->
    postLength = $(@).val().length
    lengthRemaining = 140 - postLength
    $('#counter').text lengthRemaining

