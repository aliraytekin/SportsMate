class FollowsController < ApplicationController
  def create
    followed_user = User.find(params[:user_id])
    if followed_user == current_user
      redirect_to root_path, alert: "You cannot follow yourself"
      return
    end

    current_user.following << followed_user unless current_user.following.include?(followed_user)
    redirect_to user_path(followed_user)
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy if follow.follower == current_user
    redirect_to user_path(follow.followed)
  end
end
