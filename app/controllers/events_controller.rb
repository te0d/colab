class EventsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @event = @group.events.create(params[:event])
    
    redirect_to group_path(@group)
  end
end
