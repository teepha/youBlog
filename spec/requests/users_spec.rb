require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { build :user }
  let(:valid_attributes) { attributes_for(:user) }
  let(:update_params) { { :username => 'Maylord', :biography => 'I love food' } }

  describe 'POST /signup' do
    context 'when valid request' do
      it "renders new user template" do
        get "/signup"
        expect(response).to render_template(:new)
      end

      it "creates a new User and redirects to the Users page" do
        post "/users", { params: { user: valid_attributes } }
        expect(flash[:success]).to match(/Welcome to youBlog/)
        expect(response).to redirect_to(assigns(:user))
      end
    end

    context 'when invalid request' do
      let(:userx) { create :userx }
      it "does not render a different template" do
        get "/signup"
        expect(response).to_not render_template(:show)
      end

      it "does not create a new User and redirects to the Signup page" do
        post "/users", { params: { user: { username: userx.username, email: userx.email, password: "password" } } }
        expect(flash[:danger]).to eq("Sorry, email already exists!")
        expect(response).to redirect_to(signup_path)
      end
    end
  end

  describe 'retrieve User details' do
    let(:user) { create :user }
    before { get "/users/#{user.id}" }

    context 'when valid request' do
      it "renders show show template" do
        expect(response).to render_template(:show)
      end

      it "retrieves User details" do
        expect(response).to have_http_status(200)
        expect(response.body).to include(user.username)
      end
    end

    context 'when invalid request' do
      let(:userx) { create :userx }

      it "does not render a different template" do
        get "/users/#{userx.id}"
        expect(response).to_not render_template(:edit)
      end

      it "returns an error message if user is not found and redirects to Users page" do
        get "/users/1000"
        expect(flash[:danger]).to eq("Sorry, user not found!")
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe 'edit user details' do
    let(:user) { create :user }
    let(:userx) { create :userx }
    before { post "/login", { params: { session: { email: userx.email, password: userx.password } } } }
    
    context 'when invalid request' do
      it "returns an error if the user tries to update another user's details" do
        put "/users/#{user.id}", { params: { user: update_params } }
        expect(flash[:danger]).to eq("Sorry, you are not authorized to perform this action!")
        expect(response).to redirect_to(root_path)
      end

      it "returns an error if the update params are invalid" do
        put "/users/#{userx.id}", { params: { user: { :username => 'as' } } }
        expect(flash[:danger]).to eq("Sorry, an error occured!")
        expect(response).to redirect_to(user_path(userx))
      end
    end

    context 'when valid request' do
      it "renders the edit partial template" do
        get "/users/#{userx.id}"
        expect(response).to render_template(partial: '_edit')
      end

      it "successfully updates user details" do
        put "/users/#{userx.id}", { params: { user: update_params } }
        expect(flash[:success]).to eq("Your account was updated successfully")
        expect(response).to redirect_to(user_path(userx))
      end
    end
  end

  describe 'admin delete a user record' do
    let(:user) { create :user }
    let(:userx) { create :userx }
    let(:admin) { create :admin }
    
    context 'when valid request' do
      before { post "/login", { params: { session: { email: admin.email, password: admin.password } } } }

      it "should successfully delete a user record" do
        delete "/users/#{user.id}"
        expect(flash[:danger]).to eq("User and all articles created by user have been deleted!")
        expect(response).to redirect_to(users_path)
      end
    end
    
    context 'when invalid request' do
      before { post "/login", { params: { session: { email: userx.email, password: userx.password } } } }

      it "returns an error if the user tries to delete another user's record" do
        delete "/users/#{user.id}"
        expect(flash[:danger]).to eq("Unauthorized! Only an admin can perform this action.")
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe 'return all user records' do
    let!(:user) { create :user }
    let!(:userx) { create :userx }
    let!(:admin) { create :admin }
    
    context 'when valid request' do
      before do
        post "/login", { params: { session: { email: user.email, password: user.password } } }
        get "/users"
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "should return all user records successfully" do
        expect(assigns(:users).length).to eq(3)
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
