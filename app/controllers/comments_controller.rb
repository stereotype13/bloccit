class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = current_user.comments.build(params[:comment])
  	@comment.post = @post
    @comment.save
    #render 'posts/show'
  end

  def edit
  end

  def show
    @comment = current_user.comments.build
  end

  def update
  end

  def destroy
  end
end
