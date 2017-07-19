# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.questions').on 'click', '.edit-question-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $('.new_answer').hide();
    $('.answers').hide();
    $('form.update-question-form').show();

$(document).ready(ready);                   # вешаем функцию ready на событие document.ready
$(document).on('turbolinks:load', ready);   # вешаем функцию ready на событие page:load
$(document).on('turbolinks:update', ready); # вешаем функцию ready на событие page:update
