ready = ->
  if gon.question
    
    App.cable.subscriptions.create({
      channel: 'CommentsChannel',
      question_id: gon.question.id
    },{
      connected: ->
        @perform 'follow', gon.question.id
      ,

      received: (data) ->
        comment = JSON.parse(data)
        if !gon.current_user || (comment.user_id != gon.current_user.id)
          $('.answers').append(JST['templates/comment']({
            comment: comment
          }))
    })
