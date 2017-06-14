require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) } # синтаксис RSpec

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
  end

 describe 'GET #new' do
   sign_in_user

   before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
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

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }

    context '1) autheticated user deletes his question' do
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
    end
  end
