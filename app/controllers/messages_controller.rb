class MessagesController < ApplicationController
  before_action :authenticate_user!

  #受信メッセージ一覧
  def index
    @messages = Message.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
                       .order(created_at: :desc)
  end

  def show
    @message = Message.find_by(id: params[:id])

    if @message.nil? || (@message.sender != current_user && @message.receiver != current_user)
      redirect_to messages_path
    end

    if @message.receiver == current_user && !@message.read?
      @message.update(read: true)
    end
  end

  #メッセージ送信フォーム（生徒用）
  def new
    @message = Message.new
  end

  #メッセージ送信（生徒用）
  def create
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = User.find(params[:receiver_id]) #受信者を指定する
    @message.read = false

    if @message.save
      redirect_to messages_path
    else
      render :new
    end

  end
  
  #返信フォーム（先生用）
  def reply
    @original_message = current_user.received_messages.find(params[:id])
    @message = Message.new
  end

  #返信送信（先生用）
  def create_reply
    @original_message = current_user.received_messages.find(params[:id])
    @message = current_user.sent_messages.build(message_reply_params)
    @message.receiver = @original_message.sender
    @message.subject = "Re: #{@original_message.subject}" 
    @message.read = false
    
    if @message.save
      redirect_to messages_path
    else
      @original_message = current_user.received_messages.find(params[:id])
      render :reply
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:subject, :body).merge(sender_id: current_user.id)
  end

  def message_reply_params
    params.require(:message).permit(:body, :receiver_id).merge(sender_id: current_user.id, read: true)
  end

end
