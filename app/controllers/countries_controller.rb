class CountriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_request, only: [:index, :show, :update, :destroy]

  # GET /countries
  def index
    render json: @countries
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @countries = ISO3166::Country.all.map { |c| [c.name, c.alpha3] }.sort

    if @countries && params[:id]
      @country = @country.find(params[:id])
    end
  end
end
