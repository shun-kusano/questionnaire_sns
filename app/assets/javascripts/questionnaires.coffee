# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $ ->
    $('.date-picker').datetimepicker(pickTime: false)
    $('.datepicker').datetimepicker({
      format : "YYYY/MM/DD",
      icons: {
        previous: "fa fa-arrow-left",
        next: "fa fa-arrow-right"
      }
    })
    $('.datetimepicker').datetimepicker({
      format : "YYYY/MM/DD HH:mm",
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down",
        previous: "fa fa-arrow-left",
        next: "fa fa-arrow-right"
      }
    })
    $('#deadlineToggle1').on 'click', ->
      $('#deadline').hide()
    $('#deadlineToggle2').on 'click', ->
      $('#deadline').show()
    $('#qimageToggle1').on 'click', ->
      $('#questionnaire-image-selection').hide()
    $('#qimageToggle2').on 'click', ->
      $('#questionnaire-image-selection').show()


  #オンロードさせ、リロード時に選択を保持
  #window.onload = deadlineEntry
$(document).ready(ready)
$(document).on('page:load', ready)
