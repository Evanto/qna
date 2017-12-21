comments_channel = ->
  if gon.question_id
    App.comments = App.cable.subscriptions.create "CommentsChannel",
      connected: ->
        @perform 'follow', question_id: gon.question_id

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        comment = $.parseJSON(data)
        gon.watch
        console.log(comment)
        commentable_class_string = comment.commentable_type.toLowerCase() + '_' + comment.commentable_id
        $('.question_comments#comments-of-' + commentable_class_string).append JST["templates/comment"](comment)
        #$('.comments_list#comments_' + commentable_class_string).append JST["templates/comment"](comment)
        #commentable_item = answer_32
        #
  else
    if (App.comments)
      App.cable.subscriptions.remove(App.comments)


$(document).on('turbolinks:load', comments_channel)
$(document).on('page:load', comments_channel)
$(document).on('page:update', comments_channel)
