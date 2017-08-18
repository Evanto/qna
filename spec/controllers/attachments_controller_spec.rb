require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:question)  { create(:question) }
  let(:answer)    { create(:answer, question: question, user: @user) }
  let(:answer2)   { create(:answer, question: question) }

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:attachment) { create(:attachment, attachable: answer) }

    context 'answer of author' do

      it 'deletes attach of author' do
        expect { delete :destroy, params: { attachable: answer, id: attachment.id, format: :js }  }.to change(Attachment, :count).by(-1)
      end

      it 'renders destroy template' do
        delete :destroy, params: { attachable: answer, id: attachment.id, format: :js }
        expect(response).to render_template :destroy
      end
    end

    context 'answer of somebody' do
      let!(:attachment2) { create(:attachment, attachable: answer2) }

      it 'not deletes attach of somebody' do
        expect { delete :destroy, params: { attachable: answer2, id: attachment2.id, format: :js } }.to change(Attachment, :count).by(0)
      end
    end
  end
end
