# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->
  #ready = ->
#$(document).on 'ready page:load', ->
  #　カレンダー表示用
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

  # 回答締め切り入力切り替え用
  $('#deadlineToggle1').on 'click', ->
    $('#deadline').hide()
  $('#deadlineToggle2').on 'click', ->
    $('#deadline').show()
  # 画像入力切り替え用
  $('#qimageToggle1').on 'click', ->
    $('#questionnaire-image-selection').hide()
  $('#qimageToggle2').on 'click', ->
    $('#questionnaire-image-selection').show()

  # 回答用A/B切り替え用
  $('#a-radio-button').on 'click', ->
    $('#b-radio-button').prop( "checked", false )
  $('#b-radio-button').on 'click', ->
    $('#a-radio-button').prop( "checked", false )
  # 切り替えた方の回答をsubmit
  $('#send-submit').on 'click', ->
    if $('#a-radio-button').prop('checked')
      $('#new_answera').submit()
    else
      $('#new_answerb').submit()

  #　選択肢の選択方法の切り替え
  $('#optionSelectMakeToggle1').on 'click', ->
    $('.select-options').show()
    $('.make-options').hide()
  $('#optionSelectMakeToggle2').on 'click', ->
    $('.select-options').hide()
    $('.make-options').show()

  # 選択したフォーマットにしたがって、選択肢を入力
  $('#new-questionnaire-commit').on 'click', ->
    if $('#optionSelectMakeToggle1').prop('checked')
      if $('#optionSelectToggle1').prop("checked")
        $('[name="questionnaire[optiona_body]"]').val(['はい'])
        $('[name="questionnaire[optionb_body]"]').val(['いいえ'])
      else if $('#optionSelectToggle2').prop("checked")
        $('[name="questionnaire[optiona_body]"]').val(['行く'])
        $('[name="questionnaire[optionb_body]"]').val(['行かない'])
      else
        $('[name="questionnaire[optiona_body]"]').val(['好き'])
        $('[name="questionnaire[optionb_body]"]').val(['嫌い'])
    $('#new_questionnaire').submit()

  # 選択したフォーマットにしたがって、選択肢を入力
  $('.questionnaire-answered').css("opacity", "0")
  $(window).scroll ->
    $('.questionnaire-answered').each ->
      imgPos = $(this).offset().top
      scroll = $(window).scrollTop()
      windowHeight = $(window).height()
      if scroll > imgPos - windowHeight + windowHeight/3
        $(".bar_1, .bar_2", @).addClass("bar-anime")
        $(".bar-caption1, .bar-caption2", @).addClass("bar-cap-anime")
        $(@).css("opacity", "1")

#オンロードさせ、リロード時に選択を保持
#window.onload = deadlineEntry
#$(document).ready(ready)
#$(document).on('page:load', ready)
