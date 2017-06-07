class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :load_question, only: [:create, :new]
  before_action :load_answer, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user # было @answer.user_id = current_user.id
    if @answer.save
      flash[:notice] = 'Your answer was successfully created.'
      redirect_to @answer.question
    else
      flash[:alert] = 'Something went wrong, please try again.'
      render :new
    end
  end

  def destroy
    @question = @answer.question
    if current_user.id == @answer.user_id
      @answer.destroy
      redirect_to @question, notice: 'Answer successfully deleted'
    else
      flash[:notice] = 'Your answer was successfully deleted.'
      redirect_to @question
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer # добавлено
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
