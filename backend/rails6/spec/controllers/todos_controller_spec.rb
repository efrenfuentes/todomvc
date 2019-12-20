require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe TodosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Todo. As you add validations to Todo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.build(:todo).attributes
  }

  let(:invalid_attributes) {
    { no_exists: 'value', completed: 123 }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TodosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET All Todos" do
    let!(:todos) { FactoryBot.create_list(:todo, 20) }

    before { get :index, params: {}, session: valid_session }

    it 'returns all questions' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to be_successful
    end
  end

  describe "GET One Todo" do
    let!(:todo) { FactoryBot.create(:todo) }

    before { get :show, params: {id: todo.to_param}, session: valid_session }

    it 'returns one todo' do
      expect(JSON.parse(response.body)['id']).to eq(todo.id)
    end

    it 'returns status code 200' do
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Todo" do
        expect {
          post :create, params: {todo: valid_attributes}, session: valid_session
        }.to change(Todo, :count).by(1)
      end

      it "renders a JSON response with the new todo" do
        post :create, params: {todo: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(todo_url(Todo.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new todo" do
        post :create, params: {todo: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) { FactoryBot.build(:todo).attributes }
    let(:todo) { FactoryBot.create(:todo) }
    before { put :update, params: {id: todo.to_param, todo: new_attributes}, session: valid_session }

    it "updates the requested todo" do
      todo.reload
      expect(todo.title).to eq(new_attributes['title'])
      expect(todo.completed).to eq(new_attributes['completed'])
    end

    it "renders a JSON response with the todo" do
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested todo" do
      todo_list = FactoryBot.create_list :todo, 10
      expect {
        delete :destroy, params: {id: todo_list.last.to_param}, session: valid_session
      }.to change(Todo, :count).by(-1)
    end
  end
end