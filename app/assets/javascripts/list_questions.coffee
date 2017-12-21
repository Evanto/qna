questions_list_channel = ->
  questionsList = $(".questions-list")

  if (questionsList.length)
    App.list_questions = App.cable.subscriptions.create "ListQuestionsChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        @perform 'follow'

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        questionsList.append JST["templates/question"](data)
  else
    if (App.list_questions)
      App.cable.subscriptions.remove(App.list_questions)

$(document).on('turbolinks:load', questions_list_channel)
$(document).on('page:load', questions_list_channel)
$(document).on('page:update', questions_list_channel)
