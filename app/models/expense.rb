class Expense
  include Mongoid::Document

  field :amount, :type=>Float
  field :description

  validates_presence_of :amount, :description
end
