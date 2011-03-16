class Ticket
  include Mongoid::Document

  field :price, :type=>Float
  field :name
  field :capacity, :type=>Integer

  validates_presence_of :name, :capacity, :price
  validates_numericality_of :capacity, :price
  embedded_in :event
end
