class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_accessible :level, :user_id, :group_id
end
