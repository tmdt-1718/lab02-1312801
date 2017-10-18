class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]
before_action :check_participating!, except: [:index]
def index
  @conversations = Conversation.participating(current_user).order('updated_at DESC')
end
def new
  redirect_to conversation_path(@conversation) and return if @conversation
  @message = current_user.messages.build
end
def show
@message = Message.new
end



private

def set_conversation
@conversation = Conversation.find_by(id: params[:id])
end
def check_participating!
  redirect_to conversations_path unless @conversation && @conversation.participates?(current_user)
end

end
