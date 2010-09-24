class BaseExpensesController < ApplicationController

  before_filter :find_event_and_expense
  helper_method :expenses_title, :expenses_path, :expenses, :expense_path, :edit_expense_path

  def create
    @expense = Expense.new(params[:expense])
    if @expense.valid?
      expenses << @expense
      @event.save!
      redirect_to expenses_path, :notice=>'Expense added'
    else
      render :index
    end
  end

  def destroy
    expenses.delete @expense
    @event.save!
    redirect_to expenses_path
  end

  def update
    @expense.assign params[:expense]
    if @expense.valid?
      @event.save
      redirect_to expenses_path
    else
      render :edit
    end
  end

  def index
    @expense = Expense.new
  end

  private

  def find_event_and_expense
    find_event
    @expense = expenses.find(params[:id]) if params[:id]
  end


end
