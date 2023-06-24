class ReservationsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find_by(params[:room_id])
    if @reservation.invalid?
      render template: "rooms/show"
      return
    end
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to reservations_path
    else
      flash[:alert] = "予約に失敗しました"
      redirect_to reservations_path
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約情報を削除しました"
    redirect_to reservations_path
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :check_in, :check_out, :people)
  end
end
