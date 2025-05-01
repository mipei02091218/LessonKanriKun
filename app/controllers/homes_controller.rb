class HomesController < ApplicationController
  def index
    @notices = Notice.includes(:user).order(created_at: :desc)
  end
end
