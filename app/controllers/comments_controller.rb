class CommentsController < ApplicationController
	before_action :set_comments, only: [:destroy]
  
  def create
    comment2 = Comment.find_by_user_id(current_user.id)
    comment1 = current_user.comments.build(comment_params)
    respond_to do |format|
        @comment = current_user.comments.build(comment_params)
        if @comment.save
          format.html { redirect_to movie_path(@comment.movie_id), notice: 'Comment added successfully' }
        else
          format.html { redirect_to '/movies', alert: "Users may only write one review per movie."}
        end         
    end
  end
  
  def new
		@comment = Comment.new
	end

  
  def destroy 
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to movie_path(@comment.movie_id), notice: 'Your item was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :movie_id)
  end
  
  def set_comments
    @comment = Comment.find(params[:id])
  end
  
end
