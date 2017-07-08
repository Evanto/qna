require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, user: @user) }

  describe 'DELETE #destroy' do
    before { answer }

    context "1) user deletes his answer" do
      it 'deletes users answer' do

        expect { delete :destroy, params: { question_id: question, id: answer } }
        .to change(Answer, :count).by(-1)
      end

      it 'redirects to question' do
        delete :destroy, params: { question_id: question, id: answer }

        expect(response).to redirect_to question_path(answer.question)
      end
    end

  context '2) user tries to delete an answer which he is not the author of' do
    let!(:answer) { create(:answer, question: question) }

    it 'does not delete the answer' do
      expect { delete :destroy, params: { question_id: question, id: answer } }
      .to_not change(Answer, :count)
    end

    it 'redirects to question' do
      delete :destroy, params: { question_id: question, id: answer }

      expect { delete :destroy, params: { question_id: question, id: answer } }
    end
  end
end

  describe 'POST #create' do
    context '1) with valid attributes' do

      it 'saves new users answer to the db' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end

      it 'creates and saves new answer to db for a logged in user' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end

      it 'redirects to show view of a question' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context '2) with invalid attributes' do
      it 'does not save new anwser to db' do
        expect { post :create, params: { question_id: question,
                 answer: attributes_for(:invalid_answer), format: :js } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question, user: @user) }

    it 'assigns answer from db to @answer' do
      patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns question from db to @question' do
      patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
      expect(assigns(:question)).to eq question
    end

    context '1) answer author' do
      it 'changes answer attributes' do
        sign_in(answer.user)
        patch :update, params: { id: answer, answer: { body: 'new answer body'}, format: :js }
        answer.reload
        expect(answer.body).to eq 'new answer body'
      end
    end

    context '2) not an answer author' do
      let!(:user2) { create(:user) }

      it "doesn't change answer attributes" do
        sign_in(user2)
        patch :update, params: { id: answer, answer: { body: 'hahaha'}, format: :js }
        answer.reload
        expect(answer.body).to_not eq 'hahaha'
      end
    end

    it 'renders an update template' do
      patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
      expect(response).to render_template :update
    end
  end
end
