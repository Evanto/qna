
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: [:create]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  private

  def load_commentable
    klass = [Question, Answer].detect{|c| params["#{c.name.underscore}_id"]}
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "comments_for_question_#{get_question_id}_and_its_answers",
      ApplicationController.render(partial: 'comments/comment', formats: :json, locals: { comment: @comment })
    )
  end

  def get_question_id
    if @commentable.class == Question
      gon.question_id
      @commentable.question_id
      @commentable.id

    elsif @commentable.class == Answer
      @commentable.question_id
    end
  end

end
