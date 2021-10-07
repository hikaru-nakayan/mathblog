class StaticPagesController < ApplicationController
  def home
    @q = Post.all.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def help
  end

  def about
  end

  def contact
  end
end
