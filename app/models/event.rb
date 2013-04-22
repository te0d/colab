class Event < ActiveRecord::Base
  belongs_to :group
  attr_accessible :description, :name, :when, :where
end
