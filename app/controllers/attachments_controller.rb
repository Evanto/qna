class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_attachment

  def destroy
    @attachable = @attachment.attachable
    if current_user.author_of?(@attachable)
      @attachment.destroy
    end
  end

private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:id)
  end
end
