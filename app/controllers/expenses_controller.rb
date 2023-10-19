class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]

  # GET /expenses or /expenses.json
  def index
    @category = Category.find(params[:category_id])
    @expenses = @category.expenses.all
  end

  # GET /expenses/new
  def new
    @author = current_user
    @category = Category.find(params[:category_id])
    @expense = Expense.new
  end

  # POST /expenses or /expenses.json
  def create
    @author = current_user
    saved_expenses = []
    category_ids = params[:expense][:category_ids].reject(&:empty?).map(&:to_i).uniq

    category_ids.each do |c_id|
      @category = Category.find(c_id)
      @expense = Expense.new(expense_params)
      @expense.author_id = current_user.id
      @category.expenses << @expense

      if @expense.save
        saved_expenses << @expense
      else
        # Handle the case where an expense couldn't be saved
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @expense.errors, status: :unprocessable_entity }
        end
      end
    end

    save?(saved_expenses, category_ids)
    # Redirect to the first category's show page after all expenses have been processed
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, :author_id)
  end

  def save?(saved_expenses, category_ids)
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
