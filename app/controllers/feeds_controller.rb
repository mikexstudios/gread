class FeedsController < ApplicationController
  def index
    @entries = Entry.order('created_at DESC').paginate(:page => params[:page])
  end

  def new
    @feed = Feed.new
  end
end
