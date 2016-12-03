class RequestsController < ApplicationController
  before_action :authenticate_user
  before_action :set_request, only: [:index, :show, :update, :destroy]

  # GET /requests
  def index
    @requests.each do |request|
      request.requested_by = request.user.id
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
    if @request.update(request_params)
      render json: @request
    else
      render json: @request.errors, status: :unprocessable_entity
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
      @requests = power.requests
      if params[:id]
        @request = @requests.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def request_params
      params.require(:data).permit(:attributes => [:from, :to, :description, :status])
    end
end
