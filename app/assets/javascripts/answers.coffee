# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Объявляем функцию ready, внутри которой можно поместить обработчики событий и другой код,
# который должен выполняться при загрузке страницы

ready = ->
  $('.answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId'); # answerId берется из дива
    $('form#edit-form').hide();
    $('form#edit-answer-' + answer_id).show();
    $('.warning').remove(); # удаляем ворнинг при нажатии на edit
  $('.answers').on 'click', '.set-best-link', (e) ->
    e.preventDefault();
    $('.set-best-link').show();
    $(this).hide();
    answer_id = $(this).data('answerId'); # answerId берется из дива
    $('p').removeClass('glyphicon glyphicon-star');
    $('p.answer-' + answer_id).addClass('glyphicon glyphicon-star');
    $('div.answer-' + answer_id).prependTo('div.answers');
    return;

$(document).ready(ready);                   # вешаем функцию ready на событие document.ready
$(document).on('turbolinks:load', ready);   # вешаем функцию ready на событие page:load
$(document).on('turbolinks:update', ready); # вешаем функцию ready на событие page:update
