require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question} }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'builds a new attachment for a question' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end
  end

 describe 'GET #new' do
   sign_in_user

   before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds a new attachment for a question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

 describe 'GET #edit' do
   sign_in_user

   before { get :edit, params: { id: question} }

   it 'assign the requested question to @question' do
     expect(assigns(:question)).to eq question
   end

   it 'renders edit view' do
     expect(response).to render_template :edit
   end
  end

  describe 'POST #create' do
    sign_in_user

    context '1) with valid attributes' do
      it 'saves the new question to the db' do
        expect { post :create, params: { user_id: user, question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to (assigns(:question)) #
      end
    end

    context '2) with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context '1) valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end


      it 'redirects to the updated question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(response).to redirect_to question
      end
    end

    context '2) invalid attributes (params)' do
      before { patch :update, params: { id: question, question: { title: 'new title', body: nil } }, format: :js }

      it 'does not change question attributes' do
        question.reload
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    before { question }

    context '1) authenticated user deletes his question' do
      let(:question) { create(:question, user: @user) }

      it 'deletes question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: question }

        expect(response).to redirect_to questions_path
      end
    end

    context '2) authenticated user tries to delete some other users question' do
      let(:question) { create(:question) }

      it 'tries to delete question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: question }

        expect(response).to redirect_to questions_path
      end
    end
  end
end
