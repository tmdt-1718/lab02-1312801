class MessagesController < ApplicationController
  before_action :find_conversation!, except: [:index]
  def index
    @messages=Message.all
    @messages=current_user.messages.paginate(page: params[:page], :per_page => 10)
  end
def new
@message = current_user.messages.build
end

def show
  @message=Message.find(params[:id])
    impressionist(@message)
end

def create
  @receiver = User.find_by(id: params[:receiver_id])
  @conversation ||= Conversation.create(author_id: current_user.id,
                                        receiver_id: @receiver.id)
  @message = current_user.messages.build(message_params)
  @message.conversation_id = @conversation.id
  @message.save!
  flash[:success] = "Your message was sent!"
  redirect_to conversation_path(@conversation)
end

private

def message_params
  params.require(:message).permit(:body, :picture)
end
def find_conversation!
  if params[:receiver_id]
    @receiver = User.find_by(id: params[:receiver_id])
    redirect_to(conversations_path) and return unless @receiver
    @conversation = Conversation.between(current_user.id, @receiver.id)[0]
  else
    @conversation = Conversation.find_by(id: params[:conversation_id])
    redirect_to(conversations_path)  and return unless @conversation && @conversation.participates?(current_user)
  end
end
end
