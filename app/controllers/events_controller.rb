class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_events, only: %i[show edit update]

  def index
    @events = Event.all

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    if params[:query].present?
      @events = @events.search_by_title_and_description(params[:query])
    end

    # if params[:difficulty].present?
    #   @events = @events.where(difficulty: )
    # end

    if params[:date].present?
      @events = @events.where(start_time: Date.parse(params[:date]).all_day)
    end

    if params[:favorite_sports].present? && user_signed_in?
      return unless current_user.user_sport_interests.exists?

      sport_ids = current_user.user_sport_interests.where(sport_id: params[:favorite_sports]).pluck(:sport_id)

      @events = @events.where(sport_id: sport_ids)
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
                                  :price_per_participant, :free, :photos)
  end
end
