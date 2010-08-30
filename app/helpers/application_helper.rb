module ApplicationHelper
  def jquery_icon(icon, title)
    "<div class='ui-state-default ui-corner-all'><span class='ui-icon ui-icon-#{icon}' title='#{title}'>#{title}</span></div>"
  end
end
