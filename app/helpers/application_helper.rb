module ApplicationHelper
  def jquery_icon(icon, title)
    "<div class='ui-state-default ui-corner-all'><span class='ui-icon ui-icon-#{icon}' title='#{title}'>#{title}</span></div>"
  end

  def new_expense_style
    "display:none;" unless notice.present? || (@expense && !@expense.errors.empty?)
  end

  def money(amount)
    number_to_currency(amount, :unit=>'&pound;')
  end
end
