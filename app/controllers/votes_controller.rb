class VotesController < ApplicationController

before_action :authenticate_user!, except: [:show]
before_action :load_vote, only: [:reset]
before_action :load_votable, only: [:create]

def create
    if !current_user.author_of?(@votable) && !@votable.has_vote_by?(current_user)
      current_user.votes.create({value: params[:value], votable: @votable})
      render json: @votable.rating
    else
      head :unauthorized
    end
  end

  def reset
    if current_user.author_of?(@vote)
      @votable = @vote.votable
      @vote.destroy!
      render json: @votable.rating
    else
      head :unauthorized
    end
  end

private

  def load_vote
    @vote = Vote.where(user_id: current_user.id, votable_id: params[:votable_id], votable_type: params[:votable_type]).first
  end

  def load_votable
    @votable = params[:votable_type].constantize.find(params[:votable_id])
  end

  # def vote_params
  #   params.permit(:value, :votable_id, :votable_type)
  # end
end
