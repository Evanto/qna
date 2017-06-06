class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @question = current_user.questions.new(question_params)
    @answer.user_id = current_user.id
    #answer = @question.answers.new(answer_params.merge(user_id: current_user.id))
    #@answer = current_user.answers.new(answer_params)
    if @answer.save
      flash[:notice] = 'Your answer was successfully created.'
      redirect_to question_path(@question, @answer)
    else
      flash[:alert] = 'Something went wrong, please try again.'
      render :new
    end
  end

  def destroy
    @answer = @questions.answers.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer was successfully deleted.'
      redirect_to question_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
