$ ->
  $('.js-choose-photo-attachment-button').bind "click", ->
    form = $(this).closest("form")
    form.find(".js-photo-attachment-input").click()

  $('.js-photo-attachment-input').bind "change", ->
    form = $(this).closest("form")
    filename = $(this).val().replace(/^.*[\\\/]/, '')
    form.find(".js-attachment-filename").text(filename)