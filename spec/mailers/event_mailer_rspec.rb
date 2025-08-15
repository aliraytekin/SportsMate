require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  let(:user) { create(:user, email: "test@example.com") }
  let(:event) do
    create(
      :event,
      title: "Morning Run",
      description: "A fun run around the park",
      address: "Central Park",
      start_time: Time.zone.parse("2025-08-14 08:00"),
      end_time: Time.zone.parse("2025-08-14 09:00")
    )
  end
  let(:participation) { create(:participation, user: user, event: event) }

  describe "#confirmation_email" do
    let(:mail) { described_class.confirmation_email(participation) }

    it "sends to the correct user" do
      expect(mail.to).to eq([user.email])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("You're confirmed for Morning Run!")
    end

    it "assigns variables for the view" do
      expect(mail.body.encoded).to include("Morning Run")
      expect(mail.body.encoded).to include("A fun run around the park")
    end

    it "attaches an .ics calendar file" do
      attachment = mail.attachments.detect { |a| a.filename == "morning-run.ics" }
      expect(attachment).not_to be_nil
      expect(attachment.mime_type).to eq("text/calendar")
      expect(attachment.read).to include("BEGIN:VEVENT")
      expect(attachment.read).to include("SUMMARY:Morning Run")
    end
  end

  describe "#reminder_email" do
    let(:mail) { described_class.reminder_email(participation) }

    it "sends to the correct user" do
      expect(mail.to).to eq([user.email])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Reminder for Morning Run")
    end

    it "includes event details in the body" do
      expect(mail.body.encoded).to include("Morning Run")
    end
  end
end
