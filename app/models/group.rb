class Group < ActiveRecord::Base
  attr_accessible :name, :is_default
  
  has_many :permissions
  has_many :users, :through => :permissions
  
  has_many :discussions
  has_many :events
end
