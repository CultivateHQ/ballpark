class TicketsController < ApplicationController
  before_filter :find_event_and_tickets

  def index
    @tickets = @event.tickets
    @ticket =  Ticket.new
  end


  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.valid?
      @event.tickets << @ticket
      @event.save
      redirect_to event_tickets_path(@event.id), :notice=>'Ticket created'
    else
      render :action=>:index
    end
  end

  def update
    @ticket.assign params[:ticket]
    if @ticket.valid?
      @event.save
      redirect_to event_tickets_path(@event.id), :notice=>'Ticket updated'
    else
      render :action=>:index
    end
  end

  def destroy
    @event.tickets.delete @ticket
    @event.save
    redirect_to event_tickets_path(@event.id), :notice=>'Ticket removed'
  end

private
  def find_event_and_tickets
    find_event
    @tickets = @event.tickets
    @ticket = @tickets.find(params[:id]) if params[:id]
  end

end
