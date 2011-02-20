class BaseExpensesController < ApplicationController

  before_filter :find_event_and_expense
  helper_method :expenses_title, :expenses_path, :expenses, :expense_path, :edit_expense_path

  def create
    @expense = expense_class.new(expense_params)
    if @expense.valid?
      expenses << @expense
      redirect_to expenses_path, :notice=>'Expense added'
    else
      render :index
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path
  end

  def update
    @expense.update_attributes expense_params
    if @expense.valid?
      redirect_to expenses_path
    else
      render :edit
    end
  end

  def show
    redirect_to :action=>:index
  end

  def index
    @expense = expense_class.new
  end

  private

  def find_event_and_expense
    find_event
    @expense = expenses.find(params[:id]) if params[:id]
  end

  def expense_params
    params[expense_class.name.underscore]
  end


end
