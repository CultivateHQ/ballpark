class Sponsor
  include Mongoid::Document

  field :name
  field :price, :type=>Float
  field :number_of_tickets, :type=>Integer

  validates_presence_of :name, :price, :number_of_tickets
  validates_numericality_of :price, :number_of_tickets

  embedded_in :event, :inverse_of=>:sponsors
end
