class CommentsController < ApplicationController
  def new
  end

  def create
	@post = Post.find(params[:post_id])
	@comment = current_user.comments.build(params[:comment])
	@comment.post = @post
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
