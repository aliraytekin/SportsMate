class PaymentsController < ApplicationController
  def payment
    @event = Event.find(params[:event_id])
    authorize @event

    if @event.price_per_participant == 0
      redirect_to event_payment_confirmation_path(@event), notice: "You successfully joined this event!"
      return
    end

    @payment_intent = Stripe::PaymentIntent.create(
      amount: @event.price_per_participant,
      currency: 'eur',
      metadata: { event_id: @event.id }
    )
  end

  def success
    @event = Event.find(params[:event_id])
    authorize @event, :payment?
    redirect_to confirmation_event_path(@event), notice: "You have successfully joined this event!"
  end

  def confirmation
    @event = Event.find(params[:event_id])
    authorize @event, :confirmation?
  end
end
