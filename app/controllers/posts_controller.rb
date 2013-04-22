class PostsController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @post = @discussion.posts.create(params[:post])
    
    redirect_to discussion_path(@discussion)
  end
end
