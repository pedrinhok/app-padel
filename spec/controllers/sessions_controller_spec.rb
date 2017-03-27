require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	let(:user) { FactoryGirl.create(:user) }

	describe "GET #new" do

		context "when user is authenticated" do
			it "redirects to users#index" do
				post :create, { session: { email: user.email, password: user.password } }
				get :new
				expect(response).to redirect_to(users_path)
			end
		end

		context "when user is not authenticated" do
			it "renders sessions#new" do
				get :new
				expect(response).to render_template(:new)
			end
		end

	end

	describe "POST #create" do

		context "with invalid params" do
			it "return error message" do
				post :create, { session: { email: user.email, password: "#{user.password}." } }
				expect(flash[:danger]).to_not be_nil
			end
			it "renders sessions#new" do
				post :create, { session: { email: user.email, password: "#{user.password}." } }
				expect(response).to render_template(:new)
			end
		end

		context "with valid params" do
			it "authenticates user" do
				post :create, { session: { email: user.email, password: user.password } }
				expect(session[:user_id]).to eq(user.id)
			end
			it "redirects to users#index" do
				post :create, { session: { email: user.email, password: user.password } }
				expect(response).to redirect_to(users_path)
			end
		end

	end

	describe "DELETE #destroy" do

		it "destroys user session" do
			post :create, { session: { email: user.email, password: user.password } }
			delete :destroy
			expect(session[:user_id]).to be_nil
		end
		it "redirects to sessions#new" do
			post :create, { session: { email: user.email, password: user.password } }
			delete :destroy
			expect(response).to redirect_to(sign_in_path)
		end

	end

end