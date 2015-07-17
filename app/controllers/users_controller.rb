class UsersController < ApplicationController
  before_action :set_users, only: :index
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
    def set_users
      @users = User.where(user_params).order(sort_by).page(params[:page])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name)
    end
end
