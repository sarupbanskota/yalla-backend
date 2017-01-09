class RequestsController < ApplicationController
  before_action :authenticate_user
  before_action :set_request, only: [:index, :show, :update, :destroy]

  # GET /requests
  def index
    @requests = @requests.status(params[:status])  if params[:status].present?
    @requests = @requests.search(params[:username]) if params[:username].present?
    @requests.each do |request|
      request.requested_by = request.user.email.split('@').first.split('.').join(" ").titleize
      request.requested_by_avatar = request.user.avatar
    end
    render json: @requests
  end

  def calendar_events
    # eventually needs to use Booking objects instead
    # Booking being daily log of events
    data = []
    User.all.each do |user|
      requests = []
      user.requests.each do |request|
        requests << {
          from:        request.from,
          to:          request.to,
          description: request.description,
        }
      end
      data << {
        username:   user.email.split('@').first.split('.').join(" ").titleize,
        avatar:     user.avatar,
        identifier: user.email.split('@').first.split('.').first,
        requests:   requests,
      }
    end

    render json: data
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
      params.require(:data).permit(:attributes => [:from, :to, :description, :status])
    end
end
