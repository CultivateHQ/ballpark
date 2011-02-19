class Ticket
  include Mongoid::Document

  field :price, :type=>Float
  field :name
  field :capacity, :type=>Integer

  validates_presence_of :name, :capacity, :price
  embedded_in :event
end
