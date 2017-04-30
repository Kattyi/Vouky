class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    # OPTIMIZE move to model user.rb
    if params[:term]
      @users = User.where('lower(name) LIKE ?', "%#{params[:term]}%".downcase).order(created_at: :desc).page params[:page]
    else
      @users = User.order(created_at: :desc).page params[:page]
      @users.without_count
    end

  end

  def show
    @user = User.find(params[:id])
    @groups_member = GroupsMember.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    User.transaction do
      @user = User.where(email: params[:user][:email]).first_or_create(user_params)
      @groups_member = GroupsMember.where(user_id: @user.id, group_id: params[:user][:groups_member][:group_id])
                           .first_or_create(user_id: @user.id, group_id: params[:user][:groups_member][:group_id])
    end
    @user.send_activation_email
    flash[:info] = "Please check your email to activate your account."
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    User.transaction do
      if @user.update_attributes(user_params)
        @groups_member = GroupsMember.where(user_id: @user.id, group_id: params[:user][:groups_member][:group_id])
                             .first_or_create(user_id: @user.id, group_id: params[:user][:groups_member][:group_id])
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :term, :groups_member)
  end

  def groups_member_params
    params.permit(:user_id, :group_id)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
