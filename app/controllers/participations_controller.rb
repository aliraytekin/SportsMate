class ParticipationsController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @participations = policy_scope(Participation)
  end

  def new
    @participation = Participation.new
    authorize @participation
  end

  def create
    @participation = Participation.new(participation_params)
    @event = Event.find(params[:event_id])
    @participation.event = @event
    @partipation.user = current_user

    authorize @participation

    if @participation.save
      redirect_to event_participations_path(@participation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @participation = Participation.find(params[:id])
    authorize @participation
  end

  def update
    @participation = Participation.find(params[:id])

    authorize @participation

    if @participation.update(participation_params)
      redirect_to participations_path, notice: "Participation status updated successfully."
    else
      redirect_to participations_path, alert: "Error updating participation status."
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:status)
  end
end
