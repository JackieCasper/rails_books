class SessionsController < ApplicationController
  before_action :logged_in, only: [:new]

  def new; end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user
      if @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:user] = { password: ['Incorrect password'] }
        redirect_to 'login'
      end
    else
      flash[:user] = { email: ['No user with that email'] }
      redirect_to 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
