class ExpensesController < ApplicationController

  before_filter :find_event

  def create
    @expense = Expense.new(params[:expense])
    @event.fixed_expenses << @expense
    if @expense.valid? && @event.save
      redirect_to event_expenses_path(@event.id)
    else
      render :index
    end
  end

  def index
    @expense = Expense.new
  end
  private

  def find_event
    @event = Event.find(params[:event_id])
  end

end
