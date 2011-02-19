class FixedExpense < Expense
  embedded_in :event, :inverse_of=>:fixed_expenses
end
