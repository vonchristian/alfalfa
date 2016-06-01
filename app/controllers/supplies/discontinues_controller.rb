class Supplies::DiscontinuesController < ApplicationController

  before_action :load_post

  def update
    @post.favorite!
  end

  def destroy
    @post.unfavorite!
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

end
