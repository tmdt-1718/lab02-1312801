class UsersController < ApplicationController
  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def show
    @user=User.find(params[:id])
  end

  def create
    @user =User.new(user_params)
    if @user.save
       UserMailer.welcome_email(@user).deliver_now
      log_in @user
      flash[:success]="U created an account successfully!!"
      redirect_to conversations_path
    else
      flash[:error]="Fails!!"
      render 'new'
    end
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
