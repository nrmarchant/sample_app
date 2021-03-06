class UsersController < ApplicationController
  before_action :signed_in_user,      only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,        only: [:edit, :update]
  before_action :admin_user,          only: :destroy
  before_action :not_signed_in_user,  only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      Confirmation.create(user_id: @user.id, state: 0, previous_email: @user.email)
      @user.send_email_confirmation
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to(root_url)
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      if @user.confirmation.previous_email != @user.email
        @user.confirmation.update_email
        @user.send_update_email
      end
      flash[:success] = "Profile updated"
      redirect_to(root_url)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def not_signed_in_user
      redirect_to root_url, notice: "Sign out before creating new users" unless !signed_in?
    end
end
