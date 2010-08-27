class FixedExpensesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    event.add_fixed_expense params[:event_expense]
    event.save
    redirect_to event_fixed_expenses_path(event.id)
  end

  def index
    @event = Event.find(params[:event_id])
    @fixed_expense = Event::Expense.new
  end
end
