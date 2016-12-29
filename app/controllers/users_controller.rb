class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: [:index, :show, :update, :destroy]

  # GET /users
  def index
    @users = @users.auth_id(params[:auth_id]) if params[:auth_id].present?
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      power = Power.new current_user
      @users = power.users
      if params[:id]
        @user = @users.find(params[:id])
      end
    end

    def set_request
      power = Power.new current_user
      if action_name == 'update'
        @users = power.patchable_users
      else
        @users = power.users
      end

      if @users && params[:id]
        @user = @users.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:data).permit(:attributes => [:country, :auth_id, :email, :timezone, :avatar])
    end
end
