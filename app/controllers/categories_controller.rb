class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_category, only: %i[show edit destroy]

  def index
    @user = current_user
    @categories = @user.categories
  end

  def show
    @category = Category.find(params[:id])
    @expenses = @category.expenses.order(created_at: :desc)
    @categories = current_user.categories
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @user = current_user
    @category = @user.categories.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_path(@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to categories_url, alert: 'Failed to destroy the category.' }
        format.json { render json: { error: 'Failed to destroy the category' }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to categories_url, alert: "An error occurred: #{e.message}" }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
