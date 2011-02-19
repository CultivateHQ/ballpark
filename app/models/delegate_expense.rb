class DelegateExpense < Expense
  embedded_in :event, :inverse_of=>:delegate_expenses
end
