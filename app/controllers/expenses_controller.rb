class ExpensesController < ApplicationController

  before_filter :find_event_and_expense
  helper_method :expenses_title, :expenses_path, :expenses, :expense_path, :edit_expense_path

  def create
    @expense = Expense.new(params[:expense])
    if @expense.valid?
      @event.fixed_expenses << @expense
      @event.save!
      redirect_to event_expenses_path(@event.id)
    else
      render :index
    end
  end

  def destroy
    @event.fixed_expenses.delete @expense
    @event.save!
    redirect_to event_expenses_path(@event.id)
  end

  def update
    @expense.assign params[:expense]
    if @expense.valid?
      @event.save
      redirect_to event_expenses_path(@event.id)
    else
      render :edit
    end
  end

  def index
    @expense = Expense.new
  end

  private

  def find_event_and_expense
    @event = Event.find(params[:event_id])
    @expense = @event.fixed_expenses.find(params[:id]) if params[:id]
  end

  def expenses_title
    "Fixed expenses"
  end

  def expenses_path
    event_expenses_path(@event)
  end

  def expenses
    @event.fixed_expenses
  end

  def expense_path(expense=@expense)
    event_expense_path(@event.id, expense.id)
  end

  def edit_expense_path(expense)
    edit_event_expense_path(@event.id, expense.id)
  end

end
