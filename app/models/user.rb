class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable


  validates_uniqueness_of  :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation

  references_many :events
end

