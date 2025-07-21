class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.event = @event

    authorize @comment

    if @comment.save
      redirect_to @event
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
