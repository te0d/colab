class Group < ActiveRecord::Base
  attr_accessible :name
  
  has_many :permissions
  has_many :users, :through => :permissions
end
