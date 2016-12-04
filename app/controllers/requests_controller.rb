class RequestsController < ApplicationController
  before_action :authenticate_user
  before_action :set_request, only: [:index, :show, :update, :destroy]

  # GET /requests
  def index
    @requests = @requests.status(params[:status]) if params[:status].present?
    @requests = @requests.username(params[:username]) if params[:username].present?
    @requests.each do |request|
      request.requested_by = request.username
    end
    render json: @requests
  end

  # GET /requests/1
  def show
    render json: @request
  end

  # POST /requests
  def create
    @request = Request.new request_params
    @request.user = current_user

    if @request.save
      render json: @request, status: :created, location: @request
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /requests/1
  def update
    if @request
      if @request.update(request_params)
        render json: @request
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    else
      render json: { :errors => ["Forbidden"] }
    end
  end

  # DELETE /requests/1
  def destroy
    @request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      power = Power.new current_user
      if action_name == 'update'
        @requests = power.patchable_requests
      else
        @requests = power.requests
      end

      if @requests && params[:id]
        @request = @requests.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def request_params
      params.require(:data).permit(:attributes => [:from, :to, :description, :status, :username])
    end
end
