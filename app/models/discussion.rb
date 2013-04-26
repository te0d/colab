class Discussion < ActiveRecord::Base
  attr_accessible :description, :name, :group_id
  
    belongs_to :group
    has_many :users, :through => :group
    has_many :posts
end
