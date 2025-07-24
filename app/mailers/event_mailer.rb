class EventMailer < ApplicationMailer
  default from: 'sportsmateteam@gmail.com'

  def confirmation_email(participation)
    @participation = participation
    @event = participation.event
    @user = participation.user

    # Generate .ics calendar attachment
    calendar = Icalendar::Calendar.new
    calendar.event do |e|
      e.dtstart     = @event.start_time.to_datetime
      e.dtend       = @event.end_time.to_datetime
      e.summary     = @event.title
      e.description = @event.description
      e.location    = @event.address
    end
    calendar.publish

    attachments["#{@event.title.parameterize}.ics"] = {
      mime_type: 'text/calendar',
      content: calendar.to_ical
    }

    mail(to: @user.email, subject: "You're confirmed for #{@event.title}!")
  end

  def reminder_email(participation)
    @participation = participation
    @event = participation.event
    @user = participation.user

    mail(to: @user.email, subject: "Reminder for #{@event.title}")
  end
end
