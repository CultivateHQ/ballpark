class FixedExpensesController < BaseExpensesController
private

  def expenses_title
    "Fixed expenses"
  end

  def expenses_path
    event_fixed_expenses_path(@event)
  end

  def expenses
    @event.fixed_expenses
  end

  def expense_path(expense=@expense)
    event_fixed_expense_path(@event.id, expense.id)
  end

  def edit_expense_path(expense)
    edit_event_fixed_expense_path(@event.id, expense.id)
  end

  def expense_class
    FixedExpense
  end
end
