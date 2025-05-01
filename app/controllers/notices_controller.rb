class NoticesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher!

  def new
    @notice = Notice.new
  end

  def create
    @notice = current_user.notices.build(notice_params)
    if @notice.save
      redirect_to root_path, notice: "お知らせを投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:content)
  end

  def ensure_teacher!
    unless current_user.teacher?
      redirect_to root_path, alert: "先生のみが操作できます"
    end
  end
end
