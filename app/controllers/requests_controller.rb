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
    data = []
    Team.users.each do |user|
      user.bookings.each do |booking|
        if booking.request.id == ongoing_request.id
          calendar_event.to = booking.to
        else
          data[user.email].requests << calendar_event
          # create new calendar event
          ongoing_request = booking.request
          calendar_event = {
            from:        ongoing_request.date,
            to:          ongoing_request.date,
            description: ongoing_request.request.description,
            type:        ongoing_request.request.type
          }
        end
      end
    end
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
