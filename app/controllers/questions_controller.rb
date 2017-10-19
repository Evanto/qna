class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    #gon.users = User.limit(10)
    gon.question = @question
    @answer = @question.answers.build
    @answer.attachments.build
  #gon.question_id = params[:id]

  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit

  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question was successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if current_user.author_of? @question
      @question.destroy
      flash[:notice] = 'Your question was successfully deleted.'
      redirect_to questions_path
    else
      redirect_to questions_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end

end
