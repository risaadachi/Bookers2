class UsersController < ApplicationController
	  before_action :authenticate_user!
	  before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
		@book = Book.new
	end
	#ユーザーの投稿一覧

	def edit
		@user = User.find(params[:id])
	end
	#User info プロフィール編集

	def update
		@user = User.find(params[:id])
	   if @user.update(user_params)
	 	  flash[:notice] = "You have update user successfully."
	      redirect_to user_path(@user.id)
	   else
	      render("users/edit")
	   end
	end

	def show
		@user =User.find(params[:id])
		@books = @user.books
		@book = Book.new
	end
	#ユーザーの投稿した本一覧

  private
    def correct_user
    user = User.find(params[:id])
      if current_user != user
        redirect_to user_path(current_user.id)
      end
    end

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
  end