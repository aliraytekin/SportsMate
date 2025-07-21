class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_events, only: %i[show edit update]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @events = policy_scope(Event)

    if params[:query].present?
      @events = @events.search_by_title_and_description(params[:query])
    end

    if params[:location].present?
      @events = @events.where(
        "city ILIKE :location OR street ILIKE :location OR country ILIKE :location",
        location: "%#{params[:location]}%"
      )
    end

    if params[:difficulty].present?
      @events = @events.where(difficulty: params[:difficulty])
    end

    if params[:date_range].present? && params[:date_range].include?(" to ")
      start_str, end_str = params[:date_range].split(" to ")

      start_date = Date.parse(start_str).beginning_of_day
      end_date = Date.parse(end_str).end_of_day

      @events = @events.where(start_time: start_date..end_date)
    end

    if params[:favorite_sports].present? && user_signed_in?
      return unless current_user.user_sport_interests.exists?

      sport_ids = current_user.user_sport_interests.where(sport_id: params[:favorite_sports]).pluck(:sport_id)

      @events = @events.where(sport_id: sport_ids)
    end

    if params[:latitude].present? && params[:longitude].present? && params[:radius].present?
      @events = @events.near(
        [params[:latitude], params[:longitude]], params[:radius].to_i
      )
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    @participants = @event.participations.includes(:user)
  end

  def new
    @event = Event.new
    @sports = Sport.all
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    authorize @event

    if @event.save
      redirect_to @event, notice: "The event was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @sports = Sport.all
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def cancel_event
    @event = Event.find(params[:id])
    authorize @event, :cancel?

    @event.cancelled!
    notify_cancel_event
    redirect_to @event, notice: "Event cancelled."
  end

  def notify_cancel_event
    user.followers.each do |follower|
      Notification.create!(
        recipient: follower,
        actor: user,
        event: self,
        action: "cancelled_event"
      )
    end
  end

  private

  def set_events
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:title, :description, :difficulty, :start_time, :end_time, :country, :city, :street, :venue, :max_participants,
      :price_per_participant, :free, :sport_id, photos: [])
  end
end
