class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if user.closed
        session[:user_id] = nil
        redirect_to signin_path, notice: "Your account is closed, please contact admin"
      else
        redirect_to user, notice: "Welcome back!"
      end
    else
      redirect_to signin_path, notice: "Username and/or password mismatch."
    end
  end

  def create_oauth
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
