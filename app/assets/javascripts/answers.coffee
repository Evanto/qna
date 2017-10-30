# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Объявляем функцию ready, внутри которой можно поместить обработчики событий и другой код,
# который должен выполняться при загрузке страницы

ready = ->
  if gon.question
    App.cable.subscriptions.create({
      channel: 'AnswersChannel',
      question_id: gon.question.id
    },{
      connected: ->
        @perform 'follow'
      ,

      received: (data) ->
        #answer = JSON.parse(data)
        if !gon.current_user || (answer.user_id != gon.current_user.id)
          $('.answers').append(JST['templates/answer']({
            answer: answer
          }))
          #$('.answer').append data['answer']
    })

  $('.answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-form').hide();
    $('form#edit-answer-' + answer_id).show();
    $('.warning').remove();
  $('.answers').on 'click', '.set-best-link', (e) ->
    e.preventDefault();
    $('.set-best-link').show();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('p').removeClass('glyphicon glyphicon-star');
    $('p.answer-' + answer_id).addClass('glyphicon glyphicon-star');
    $('div.answer-' + answer_id).prependTo('div.answers');
    return;

$(document).on('turbolinks:load', ready);   # вешаем функцию ready на событие page:load
