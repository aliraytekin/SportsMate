class EventsController < ApplicationController
  before_action :set_events, only: %i[show edit update]

  def index
    @events = Event.all
    @markers = @events.geocoded.map do |event|
    {
      lat: event.latitude,
      lng: event.longitude
    }
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to @event, notice: "The event was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def cancel_event
  end

  private

  def set_events
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :descritpion, :start_time, :end_time, :address, :venue, :max_participants,
                                  :price_per_participant, :free)
  end
end
