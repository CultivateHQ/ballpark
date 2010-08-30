class ExpensesController < ApplicationController

  before_filter :find_event_and_expense

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

end
