class UserSportInterestsController < ApplicationController
before_action :set_user, only: %i[new edit]
before_action :set_user_sport_interest, only: %i[edit update destroy]


  def new
    @user_sport_interest = UserSportInterest.new
  end

  def create
    @user_sport_interest = UserSportInterest.new(user_sport_interests_params)
    @user_sport_interest.user = current_user


    if @user_sport_interest.save
      redirect_to user_path(current_user), notice: "Thanks for updating your interests!"
    else
      render "users/show", status: :unprocessable_entity
    end
  end

  def edit
    authorize current_user
  end

  def update
    if @user_sport_interest.update(user_sport_interests_params)
      redirect_to user_path(current_user), notice: "Your interests have been updated."
    else
     render "users/show", status: :unprocessable_entity
    end
  end

  def destroy
    @user_sport_interest.destroy
    redirect_to user_path(current_user), notice: 'Sport interest was successfully deleted.'
  end

  private

  def user_sport_interests_params
    params.require(:user_sport_interest).permit(:skill_level, :sport_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_sport_interest
    @user_sport_interest = UserSportInterest.find(params[:id])
  end

end
