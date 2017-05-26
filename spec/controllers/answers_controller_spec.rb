require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do

    before { get :new, params: { question_id: question} }

    it 'assigns a new Answer to @answer' do
       expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'checks that new answer corresponds to a question' do # новая проверка для ответов, в вопросах нам она была не нужна
      expect(assigns(:question).answers.first).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves new answer to the db' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question, assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save new anwser to db' do
        expect { post :create, params: { question_id: question,
                 answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer)}
        expect(response).to render_template :new
      end
    end
  end

end
