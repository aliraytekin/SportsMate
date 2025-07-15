class ParticipationsController < ApplicationController
  def index
    @participations = Participation.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    @participation = Participation.find(params[:id])
    if @participation.update(participation_params)
      redirect_to participations_path, notice: "Participation status updated successfully."
    else
      redirect_to participations_path, alert: "Error updating participation status."
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:status)
  end
end
