class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @rooms = Room.all
  end
  
  def new
    @user = current_user
    @room = Room.new
  end
  
  def create
    @user = current_user
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "施設登録が完了しました"
      redirect_to rooms_own_path
    else
      render "rooms/new"
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end
  
  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end
  
  def update
    @user = current_user
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報を変更しました"
      redirect_to rooms_own_path
    else
      render "edit"
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報を削除しました"
    redirect_to root_path
  end
  
  def own
    @rooms = Room.where(user_id: current_user.id)
  end

  def search
    @rooms = Room.all
    @keyword = params[:keyword]
    if params[:target] == "area"
      @rooms = Room.where('address LIKE(?)', "%#{@keyword}%")
    else
      @rooms = Room.where(['name LIKE(?) OR introduction LIKE(?)',"%#{@keyword}%","%#{@keyword}%"])
    end
  end
  
  private
  
  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :user_id, :image)
  end

end
