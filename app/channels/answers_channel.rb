class AnswersChannel < ApplicationCable::Channel
  def follow
    #stop_all_streams
    stream_from "question_answers_#{params[:question_id]}"
  end
end
