class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_sport_interest = UserSportInterest.new
  end

  def chat
    @user = User.find(params[:id])

    @messages = Message.where(
      "(sender_id = :current AND recipient_id = :other) OR (sender_id = :other AND recipient_id = :current)",
      current: current_user.id,
      other: @user.id
    ).order(created_at: :asc)

    @new_message = Message.new
  end
end
