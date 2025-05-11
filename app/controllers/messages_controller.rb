class MessagesController < ApplicationController
  before_action :authenticate_user!

  #受信メッセージ一覧（先生用）
  def index
    @messages = current_user.received_messages.order(created_at: :desc)
  end

  def show
    @message = current_user.received_messages.find(params[:id])
  end

  #メッセージ送信フォーム（生徒用）
  def new
    @message = Message.new
  end

  #メッセージ送信（生徒用）
  def create
    @message = current_user.sent_messages.new(message_params)
    @message.receiver = User.find(params[:receiver_id]) #受信者を指定する

    if @message.save
      redirect_to message_path, notice: 'メッセージを送信しました'
    else
      render :new
    end

  end
  
  #返信フォーム（先生用）
  def reply
    @message = current_user.received_messages.find(params[:id])
  end

  #返信送信（先生用）
  def update_reply
    @message = current_user.received_messages.find(params[:id])
    if @message.update(message_reply_params)
      redirect_to message_path, notice: '返信を送信しました'
    else
      render :reply
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:subject, :body).merge(sender_id: current_user.id)
  end

  def message_reply_params
    params.require(:message).permit(:body).merge(sender_id: current_user.id, read: true)
  end
  
end
