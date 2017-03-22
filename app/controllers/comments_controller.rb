class CommentsController < ApplicationController
  def create
    @comment = Comment.new(content:params[:content], user_id:session[:user_id], event_id:params[:id])
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = ["Your comment could not be created!"]
      redirect_to :back
    end
  end
end
