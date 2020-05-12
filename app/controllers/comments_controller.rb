class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id |= current_user.id
    @book = Book.find(params[:book_id])

    flash[:comment] = @comment.errors.messages unless @comment.save

    redirect_back fallback_location: @book
  end

  def update
    flash[:comment] = @comment.errors.messages unless @comment.update(comment_params)

    redirect_back fallback_location: Book.find(params[:book_id])
  end

  def destroy
    @comment.destroy
    redirect_back fallback_location: @comment
  end

private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end
end
