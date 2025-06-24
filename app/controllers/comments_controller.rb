class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.commentable, notice: "Commented successfully."
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to @comment.commentable, notice: "Comment deleted."
    else
      redirect_to @comment.commentable, alert: "Not authorized"
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:task_id]
      Task.find(params[:task_id])
    else
      raise ActiveRecord::RecordNotFound, "Commentable not found"
    end
  end
end
