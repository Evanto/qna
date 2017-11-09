class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: [:create]

  after_action :publish_comment, only: [:create]

  def create
    @comment = @commentable.comments.create(comment_params.merge(user: current_user))
  end

private
  def load_commentable
    @commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type);
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
      @commentable.id
    elsif @commentable.class == Answer
      @commentable.question_id
    end
  end
end
