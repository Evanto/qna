class CommentsChannel < ApplicationCable::Channel
  def follow
    #stop_all_streams

    #gon.question_id
    stream_from "comments_for_question_#{params[:question_id]}_and_its_answers"

  end

  def unfollow
    stop_all_streams
  end
end
