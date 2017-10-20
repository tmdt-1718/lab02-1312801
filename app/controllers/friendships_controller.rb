class FriendshipsController < ApplicationController
  def index
    @friendships=Friendship.all
  end
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:success] = "Added friend."
      redirect_to conversations_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to conversations_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end
end
