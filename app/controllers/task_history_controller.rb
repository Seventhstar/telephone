class TaskHistoryController < ApplicationController
  include CommonHelper
  def index
      page = params[:page].nil? ? 1 : params[:page]
      @history = PaperTrail::Version.where(item_type: 'Task' ).order(created_at: :desc).paginate(:page => page, :per_page => 20)

  end

  def show
  end
end
