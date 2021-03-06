# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow'
      console.log 'Connected!'
    ,

    received: (data) ->
      $('.questions').append data

  })

  $('.questions').on 'click', '.edit-question-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $('.new_answer').hide();
    $('.answers').hide();
    $('form.update-question-form').show();

$(document).on('turbolinks:load', ready);   # вешаем функцию ready на событие page:load
