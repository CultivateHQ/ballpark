class SponsorsController < ApplicationController
  before_filter :find_sponsor
  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.valid?
      @event.sponsors << @sponsor
      redirect_to :action=>:index
    else
      render :action=>:index
    end
  end

  def index
    @sponsor = Sponsor.new
  end

  def destroy 
    @sponsor.destroy
    redirect_to(:action=>:index)
  end

  def edit
    
  end

  def update
    if @sponsor.update_attributes(params[:sponsor])
      redirect_to :action=>:index
    else
      render :action=>:index
    end
  end

  private
  def find_sponsor
    find_event
    @sponsor = @event.sponsors.find(params[:id]) if params[:id]
  end
end
