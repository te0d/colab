class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :permissions
  has_many :groups, :through => :permissions
  
  def has_permission(group_id, level)
    permissions = self.permissions.where(:group_id => group_id)
    if permissions.any? && permissions.first.level >= level
      return true
    else
      return false
    end
  end
end
