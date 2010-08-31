require 'spec_helper'
require 'expenses_controller_spec_base'

describe DelegateExpensesController do

  include ExpensesControllerSpec

  def expenses
    @event.delegate_expenses
  end

  def assigned_expenses
    assigns(:event).delegate_expenses
  end

  def expenses_path
    event_delegate_expenses_path(@event.id)
  end
end
