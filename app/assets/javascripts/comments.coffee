comments_channel = ->
  if gon.question_id
    App.comments = App.cable.subscriptions.create { channel: "CommentsChannel", question_id: gon.question_id },
      connected: ->
        @perform 'follow'

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



$(document).on('turbolinks:load', comments_channel)
