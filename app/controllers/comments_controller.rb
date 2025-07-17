class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.event = @event

    authorize @comment

    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("comments", partial: "comments/comment", locals: { comment: @comment })
        end
        format.html { redirect_to @event }
      end
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
