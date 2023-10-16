class CategoriesController < ApplicationController
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
    if @category.save
      format.html {}
      format.json {}
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def create
    @user = current_user
    @category = @user.categories.new(category_params)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
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
