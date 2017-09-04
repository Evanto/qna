# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

votes = ->
  $(document).on 'click', '.vote-link', (e) ->
    e.preventDefault();

    value = $(this).data('value')
    votable_id = $(this).data('votableId')
    votable_type = $(this).data('votableType')

    $.ajax
      type: "POST"
      url: "/votes"
      data:
        value: value
        votable_id: votable_id
        votable_type: votable_type
      success: (rating) ->
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .reset-vote-link').show()
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .vote-link').hide()
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .rate').html(rating)
      error: ->
        $('div.errors').html('Something is wrong.')

  $(document).on 'click', '.reset-vote-link', (e) ->
    e.preventDefault();

    votable_id = $(this).data('votableId')
    votable_type = $(this).data('votableType')

    $.ajax
      type: "DELETE"
      url: "/votes/reset?" + $.param({"votable_id": votable_id, "votable_type" : votable_type})
      success: (rating) ->
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .vote-link').show()
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .reset-vote-link').hide()
        $('#' + votable_type.toLowerCase() + '_' + votable_id + ' .rate').html(rating)
      error: ->
        $('div.errors').html('Something is wrong.')

$(document).on('turbolinks:load', votes)
$(document).on('page:load', votes)
$(document).on('page:update', votes)
