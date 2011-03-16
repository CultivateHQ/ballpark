class TicketsController < ApplicationController
  before_filter :find_event_and_tickets

  def index
    @ticket =  Ticket.new
  end


  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.valid?
      @event.tickets << @ticket
      redirect_to event_tickets_path(@event.id), :notice=>'Ticket created'
    else
      render :action=>:index
    end
  end



  def update
    @ticket.update_attributes params[:ticket]
    if @ticket.valid?
      @event.save
      redirect_to event_tickets_path(@event.id), :notice=>'Ticket updated'
    else
      render :action=>:edit
    end
  end

  def show
    redirect_to_index
  end

  def update_ticket_cost_details
    if @event.update_attributes(params[:event])
      redirect_to_index
    else
      @ticket = Ticket.new
      render :action=>:index
    end
  end

  def destroy
    @ticket.destroy
    redirect_to event_tickets_path(@event.id), :notice=>'Ticket removed'
  end

private
  def find_event_and_tickets
    find_event
    @ticket = @event.tickets.find(params[:id]) if params[:id]
  end

  def redirect_to_index
    redirect_to :action=>:index
  end
end
