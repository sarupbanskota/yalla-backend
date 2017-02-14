class CategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category, only: [:index, :show, :update, :destroy]

  # GET /categories
  def index
    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new category_params

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category
      if @category.update(category_params)
        render json: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: { :errors => ["Forbidden"] }
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      power = Power.new current_user
      if action_name == 'update'
        @categories = power.patchable_categories
      else
        @categories = power.categories
      end

      if @categories && params[:id]
        @category = @categories.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:data).permit(:attributes => [:name, :color])
    end
end
