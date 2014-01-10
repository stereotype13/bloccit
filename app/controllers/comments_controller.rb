class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = current_user.comments.build(params[:comment])
  	@comment.post = @post
	
    #create a @topic variable so we know build the propper [@topic, @post] url to redirect to
  	@topic = Topic.find(params[:topic_id])
  	
  	authorize! :create, @comment, message: "You need to be a member to do that."
  	
  	if @comment.save
  		flash[:notice] = "Comment was saved."
  	else
  		flash[:error] = "There was an error saving the comment. Please try again."
  	end
  	 
  	redirect_to [@topic, @post] #builds the propper nested url 
	 
  end

  def edit
  end

  def show
    
  end

  def update
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
end