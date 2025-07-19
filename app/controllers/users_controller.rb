class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_sport_interest = UserSportInterest.new
    # @user_sport_interest.sport = @sport
  end
end
