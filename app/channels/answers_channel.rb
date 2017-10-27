class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "question_answers_#{params[:question_id]}"
  end
end
