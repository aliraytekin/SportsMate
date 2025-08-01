class ParticipationsController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @participations = policy_scope(Participation).includes(:event)
    @owned_events = Event.where(user_id: current_user.id).includes(:participations)
    @other_participations = @participations.select do |p|
      p.event.user != current_user && p.status == "attending"
    end

    @cancelled_participations = @participations.select do |p|
      p.status == "cancelled"
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @participation = Participation.new
    authorize @participation
  end

  def create
    @event = Event.find(params[:event_id])
    authorize @event, :show?

    if @event.participations.exists?(user_id: current_user.id)
      redirect_to @event, alert: "You're already in this event." and return
    end

    if @event.participations.count >= @event.max_participants
      redirect_to @event, alert: "This event is full." and return
    end

    if @event.user == current_user
      redirect_to @event, alert: "You cannot join your own event." and return
    end

    @participation = Participation.new(event: @event, user: current_user)
    authorize @participation

    if @event.free?
      @participation.status = :attending
    else
      @participation.payment_status = :pending
    end

    if @participation.save
      if @event.free?
        EventMailer.confirmation_email(@participation).deliver_now
        reminder_time = @event.start_time - 1.day
        EventMailer.reminder_email(@participation).deliver_later(wait_until: reminder_time)
        redirect_to @event, notice: "You have successfully joined the event."
      else
        redirect_to payment_event_path(@event)
      end
    else
      redirect_to @event, alert: "Failed to join the event."
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

  def cancel_participation
    @participation = Participation.find(params[:id])
    authorize @participation
    @participation.update(status: :cancelled)
    redirect_to participations_path, notice: "You have left the event."
  end

  private

  def participation_params
    params.require(:participation).permit(:status)
  end
end
