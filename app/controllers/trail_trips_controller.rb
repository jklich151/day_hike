class TrailTripsController < ApplicationController
  def destroy
    TrailTrip.find_by(trip_id: params[:trip_id], trail_id: params[:trail_id]).destroy
    redirect_to trip_path(params[:trip_id])
  end
end
