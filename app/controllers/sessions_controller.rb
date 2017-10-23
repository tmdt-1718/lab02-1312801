class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def show
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #byebug
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to conversations_path
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
end

  def destroy
    log_out
    redirect_to root_url
  end
  def failure
    render :text => "Sorry ,you not allow"
  end
end
