class UserSportInterestsController < ApplicationController
before_action :set_user, only: %i[new create edit update destroy]

  def new
    @user_sport_interest = UserSportInterest.new
    @user_sport_interest.sport = @sport
  end

  def create
    @user_sport_interest = UserSportInterest.new(user_sport_interests_params)
    @user_sport_interest.user = current_user


    if @user_sport_interest.save
      redirect_to @user, notice: "Thanks for updating your interests!"
    else
      render "users/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_sport_interests_params
    params.require(:user_sport_interest).permit(:skill_level, :sport_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_sport
    @sport = Sport.find(params[:sport_id])
  end
end
