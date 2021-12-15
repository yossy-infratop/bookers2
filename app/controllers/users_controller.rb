class UsersController < ApplicationController
  before_action :check_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @newbook = Book.new
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def check_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

end
