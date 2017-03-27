require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "GET #index" do

		it "assigns all users as @users" do
			users = (1..Random.new.rand(5..20)).map { |index| FactoryGirl.create(:user) }
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
		let(:valid_params) { { name: user.name, email: user.email, password: "pass", password_confirmation: "pass" } }
		let(:invalid_params) { { name: "", email: "invalid", password: "pass" } }

		context "with invalid params" do
			it "return error message" do
				post :create, { user: invalid_params }
				expect(flash[:danger]).to_not be_nil
			end
			it "renders users#new" do
				post :create, { user: invalid_params }
				expect(response).to render_template(:new)
			end
		end

		context "with valid params" do
			let(:user) { FactoryGirl.build(:user) }
			it "creates user" do
				post :create, { user: valid_params }
				expect(User.count).to_not be_zero
			end
			it "authenticates user" do
				post :create, { user: valid_params }
				user = assigns(:user)
				expect(session[:user_id]).to eq(user.id)
			end
			it "return success message" do
				post :create, { user: valid_params }
				expect(flash[:success]).to_not be_nil
			end
			it "redirects to users#index" do
				post :create, { user: valid_params }
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

	describe "PUT #update" do
		let(:user) { FactoryGirl.create(:user) }
		let(:valid_params) { { name: "#{user.name}." } }
		let(:invalid_params) { { name: "" } }

		context "with invalid id" do
			it "return error message" do
				sign_in user
				put :update, { id: 0, user: valid_params }
				expect(flash[:danger]).to_not be_nil
			end
		end

		context "with invalid params" do
			it "return error message" do
				sign_in user
				put :update, { id: user.id, user: invalid_params }
				expect(flash[:danger]).to_not be_nil
			end
			it "renders users#edit" do
				sign_in user
				put :update, { id: user.id, user: invalid_params }
				expect(response).to render_template(:edit)
			end
		end

		context "with valid params" do
			it "updates user attributes" do
				sign_in user
				put :update, { id: user.id, user: valid_params }
				expect(assigns(:user).name).to eq(valid_params[:name])
			end
			it "return success message" do
				sign_in user
				put :update, { id: user.id, user: valid_params }
				expect(flash[:success]).to_not be_nil
			end
			it "redirects to users#index" do
				sign_in user
				put :update, { id: user.id, user: valid_params }
				expect(response).to redirect_to(users_path)
			end
		end

		context "when user is not authenticated" do
			it "redirects to sessions#new" do
				put :update, { id: user.id, user: valid_params }
				expect(response).to redirect_to(sign_in_path)
			end
		end

	end

	describe "DELETE #destroy" do
		let(:current_user) { FactoryGirl.create(:user) }
		let(:user) { FactoryGirl.create(:user) }

		it "destroys user" do
			sign_in current_user
			delete :destroy, { id: user.id }
			expect(User.count).to be(1)
		end
		it "redirects to users#index" do
			sign_in current_user
			delete :destroy, { id: user.id }
			expect(response).to redirect_to(users_path)
		end

		context "when user authenticated is destroyed" do
			it "signs out user" do
				sign_in current_user
				delete :destroy, { id: current_user.id }
				expect(session[:user_id]).to be_nil
			end
		end

		context "with invalid id" do
			it "return error message" do
				sign_in current_user
				delete :destroy, { id: 0 }
				expect(flash[:danger]).to_not be_nil
			end
		end

		context "when user is not authenticated" do
			it "redirects to sessions#new" do
				delete :destroy, { id: user.id }
				expect(response).to redirect_to(sign_in_path)
			end
		end

	end

end