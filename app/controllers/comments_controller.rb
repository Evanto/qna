
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: [:create]

  def show
    @commentable = "Question"
    @comment = @commentable.comments.build(comment_params)
    #@comment = @commentable = Traveldeal.find(params[:id])
  end

  def create
    @commentable = @comment.commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    #@comment = @commentable.comments.build(comment_params.merge(user: current_user, id: id))
    #@comment = @commentable.comments.create(comment_params.merge(user: current_user, id: id))
    puts @commentable
  end

  private

  def load_commentable
    @commentable = @comment.commentable
      if @commentable.class == Question
        @commentable.id
      elsif @commentable.class == Answer
        @commentable.question_id
      end
  end

  def comment_params
    params.require(:comment).permit(:body, :id, :commentable_type, :commentable_id )
  end
end
