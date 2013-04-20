class Discussion < ActiveRecord::Base
  belongs_to :group
  attr_accessible :description, :name, :group_id
end
