class ExpenseController < ApplicationController
  def index
    @category = Category.find(params[:id])
    @expenses = @category.expenses.all
  end

  def new
    @author = current_user
    @category = Category.find(params[:categories_id])
  end

  def create
    @author = current_user
    saved_expenses = []
    category_ids = params[:expense][:category_ids].reject(&:empty?).map(&:to_i).uniq

    category_ids.each do |c_id|
      @category = Category.find(c_id)
      @expense = Expense.new(expense_params)
      @expense.author_id = current_user.id
      @category.expenses << @expense

      if @expense.save # Change 'expense' to '@expense' to fix the variable name
        saved_expenses << @expense
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @expense.errors, status: :unprocessable_entity }
        end
      end
    end

    save_expenses(saved_expenses, category_ids) # Correct the method call here
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :author_id)
  end

  def save_expenses(saved_expenses, category_ids) # Rename the method 'save?' to 'save_expenses'
    if saved_expenses.present?
      redirect_to category_path(category_ids.first), notice: 'Expenses were successfully created.'
    else
      # Handle the case where no expenses were successfully saved
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { error: 'No expenses were saved.' }, status: :unprocessable_entity }
      end
    end
  end
end
