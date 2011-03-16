module ApplicationHelper
  def jquery_icon(icon, title)
    "<div class='ui-state-default ui-corner-all'><span class='ui-icon ui-icon-#{icon}' title='#{title}'>#{title}</span></div>"
  end

  def new_expense_style
    "display:none;" unless notice.present? || (@expense && !@expense.errors.empty?)
  end

  def money(amount)
    number_to_currency(amount, :unit=>'')
  end

end

Formtastic::SemanticFormBuilder.class_eval do
  include ActionView::Helpers::NumberHelper
  Helper = Object.new
  Helper.extend  ActionView::Helpers::NumberHelper

  def money(field, options={})
    input field, {:as=>:numeric, :input_html=>{:value=>Helper.number_with_precision(object.send(field), :precision=>2)}}.merge(options)
  end
end
