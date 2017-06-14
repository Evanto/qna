class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer was successfully created.'
      redirect_to @answer.question
    else
      flash[:alert] = 'Something went wrong, please try again.'
     render 'questions/show'
    end
  end

  def destroy
    @question = @answer.question
    if current_user.author_of? @answer
      @answer.destroy
      render 'questions/show'
      #redirect_to question_path(question), notice: 'Answer successfully deleted'
    else
      flash[:notice] = 'Your answer was successfully deleted.'
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
