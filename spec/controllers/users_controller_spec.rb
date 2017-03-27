require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	let(:users) { (1..Random.new.rand(5..20)).map { |index| FactoryGirl.create(:user) } }

	describe "GET #index" do

		it "assigns all users as @users" do
			sign_in users.first
			get :index
			expect(assigns(:users)).to match_array(users)
		end

		context "when user is not authenticated" do
			it "redirects to sessions#new" do
				get :index
				expect(response).to redirect_to(sign_in_path)
			end
		end

	end

	describe "GET #new" do

		it "assigns new user as @user" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
		it "renders users#new" do
			get :new
			expect(response).to render_template(:new)
		end

	end

	describe "POST #create" do

		context "with invalid params" do
			let(:params) { { name: "", email: "", password: "pass" } }
			it "return error message" do
				post :create, { user: params }
				expect(flash[:danger]).to_not be_nil
			end
			it "renders users#new" do
				post :create, { user: params }
				expect(response).to render_template(:new)
			end
		end

		context "with valid params" do
			let(:user) { FactoryGirl.build(:user) }
			let(:params) { { name: user.name, email: user.email, password: "pass", password_confirmation: "pass" } }
			it "creates user" do
				post :create, { user: params }
				expect(User.count).to_not be_zero
			end
			it "authenticates user" do
				post :create, { user: params }
				user = assigns(:user)
				expect(session[:user_id]).to eq(user.id)
			end
			it "return success message" do
				post :create, { user: params }
				expect(flash[:success]).to_not be_nil
			end
			it "redirects to users#index" do
				post :create, { user: params }
				expect(response).to redirect_to(users_path)
			end
		end

	end

	describe "GET #edit" do

		let(:user) { FactoryGirl.create(:user) }

		it "assigns user as @user" do
			sign_in user
			get :edit, { id: user.id }
			expect(assigns(:user)).to eq(user)
		end

		context "with invalid id" do
			it "return error message" do
				sign_in user
				get :edit, { id: 0 }
				expect(flash[:danger]).to_not be_nil
			end
		end

		context "when user is not authenticated" do
			it "redirects to sessions#new" do
				get :edit, { id: user.id }
				expect(response).to redirect_to(sign_in_path)
			end
		end

	end

end
