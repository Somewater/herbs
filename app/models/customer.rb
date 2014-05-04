class Customer < ActiveRecord::Base
  has_many :orders

  attr_accessible :name, :phone

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
end
