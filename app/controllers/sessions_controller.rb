class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def show
  end
  def create
    if params[:session].present?
    user = User.find_by(email: params[:session][:email].downcase)
    #byebug
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to conversations_path
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  else
    begin
      user=User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id]=user.id
      flash[:success]="Welcom, #{user.email}!"
    rescue
      flash[:warning]="Error!!"
    end
    redirect_to root_path
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
