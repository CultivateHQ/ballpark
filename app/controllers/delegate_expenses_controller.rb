class DelegateExpensesController < BaseExpensesController
private

  def expenses_title
    "Delegate expenses"
  end

  def expenses_path
    event_delegate_expenses_path(@event)
  end

  def expenses
    @event.delegate_expenses
  end

  def expense_path(expense=@expense)
    event_delegate_expense_path(@event.id, expense.id)
  end

  def edit_expense_path(expense)
    edit_event_delegate_expense_path(@event.id, expense.id)
  end
end
