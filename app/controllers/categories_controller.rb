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
  end

  def create; end
  def destroy; end
end
