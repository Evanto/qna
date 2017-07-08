class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if current_user&.author_of? @answer
    #if current_user.id == @answer.user_id
    @answer.update(answer_params)
    @question = @answer.question
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
      @answer.destroy!
      flash[:notice] = 'Your answer was successfully deleted.'
      redirect_to question_path(@question)
    else
      redirect_to question_path(@question)
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
    params.require(:answer).permit(:body)
  end

end
