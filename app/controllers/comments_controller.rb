class CommentsController < ApplicationController
	before_action :set_comments, only: [:destroy]
  
  def create
    comment2 = Comment.find_by_user_id(current_user.id)
    respond_to do |format|
        @comment = current_user.comments.build(comment_params)
        if @comment.save
          format.html { redirect_to movie_path(@comment.movie_id), notice: 'Comment added successfully' }
        else
          format.html { redirect_to movie_path(comment2.movie_id), alert: "Users may only write one review per movie."}
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
  
  def show_top_ten
    @top_ten = Comment.where("comments.created_at >= ?", 1.week.ago.utc).joins(:user).group("users.name").order("count(comments.id) desc").count("comments.id").take(10)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :movie_id)
  end
  
  def set_comments
    @comment = Comment.find(params[:id])
  end
  
end
