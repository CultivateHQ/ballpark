module TicketsHelper
  def new_ticket_style
    "display:none;" unless notice.present? || (@ticket && !@ticket.errors.empty?)
  end
end
