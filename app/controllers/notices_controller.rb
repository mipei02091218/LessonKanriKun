class NoticesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher!

  def new
    @notice = Notice.new
  end

  def create
    @notice = current_user.notices.build(notice_params)
    if @notice.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update(notice_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
    redirect_to root_path
  end

  private

  def notice_params
    params.require(:notice).permit(:content)
  end

  def ensure_teacher!
    unless current_user.teacher?
      redirect_to root_path
    end
  end
end
