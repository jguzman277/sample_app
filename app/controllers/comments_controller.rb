# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :authenticate_user!

  # POST /posts/:post_id/comments
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    # Mark as notification sent if commenting on someone else's post
    @comment.notification_sent = true if @post.user != current_user

    if @comment.save
      # REMOVED: CommentNotifier.with(comment: @comment, post: @post).deliver(@post.user)
      redirect_to @post, notice: "Comment was successfully created."
    else
      # If saving fails, render the post's show page again to display errors
      @comments = @post.comments.order(created_at: :desc) # Reload comments for the view
      render "posts/show", status: :unprocessable_entity
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully deleted.", status: :see_other
  end

  def mark_notification_read
    @comment = Comment.find(params[:id])
    @comment.mark_notification_as_read!

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  def mark_all_notifications_read
    current_user.mark_all_comment_notifications_as_read!

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "All comment notifications marked as read") }
      format.turbo_stream
    end
  end

  def clear_notification
    @comment = Comment.find(params[:id])
    @comment.update(notification_sent: false, notification_read: false)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  def clear_all_notifications
    current_user.clear_all_comment_notifications!

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "All comment notifications cleared") }
      format.turbo_stream
    end
  end

  private

  # Find the parent Post from the URL
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end