class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:edit, :update, :destroy, :set_best]
  after_action :publish_answer, only: [:create]

  respond_to :js
  respond_to :json, only: [:set_best]

  def update
    if current_user&.author_of? @answer
    @answer.update(answer_params)
    @question = @answer.question
    respond_with(@answer)
    end
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @question = @answer.question
    if current_user.author_of? @answer
      respond_with(@answer.destroy!)
    end
  end

  def set_best
    question = @answer.question
    if current_user.author_of? question
      respond_with(@answer.set_best)
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "question_answers_#{@answer.question_id}",
      @answer.to_json
    )
  end

end
