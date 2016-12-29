class TimezonesController < ApplicationController
  before_action :authenticate_user
  before_action :set_request, only: [:index, :show, :update, :destroy]

  # GET /timezones
  def index
    render json: @timezones
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @timezones = TZInfo::Timezone.all.map { |t| [t.friendly_identifier(true), t.identifier] }.sort
    if @timezones && params[:id]
      @timezone = @timezone.find(params[:id])
    end
  end
end
