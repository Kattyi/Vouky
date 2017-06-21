class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env['omniauth.auth']
      user = User.create_with_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      log_in user
      redirect_to user_path(user.id)
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or languages_path
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
