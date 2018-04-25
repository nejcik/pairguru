class CommentsController < ApplicationController
	before_action :set_comments, only: [:destroy]
  
  def create
    @comment = current_user.comments.build(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to movie_path(@comment.movie_id), notice: 'Comment added successfully' }
      else
        format.html { redirect_to '/movies'}
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
