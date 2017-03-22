class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/events'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  def authenticate
    begin
      @user = User.find_by_email!(params[:email])
      if @user.password == params[:password]
        session[:user_id] = @user.id
        redirect_to '/events'
      else
        flash[:errors] = ["Your password does not match!"]
        redirect_to '/users/new'
      end
    rescue
      flash[:errors] = ["Could not match your email!"]
      redirect_to '/users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    success = user.update(user_params)
    if success
      redirect_to '/events'
    else
      @curruser = session[:user_id]
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/#{@curruser}/edit"
    end
  end

  def logout
    session.clear
    redirect_to '/users/new'
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
  end
end
