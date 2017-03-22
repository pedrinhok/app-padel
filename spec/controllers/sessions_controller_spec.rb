require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	describe "GET #new" do

		context "when user is authenticated" do

			it "redirects to users#index" do
				user = FactoryGirl.create(:user)
				post :create, { session: { email: user.email, password: user.password } }
				get :new
				expect(response).to redirect_to(users_path)
			end

		end

	end

	describe "POST #create" do

		context "with invalid params" do

			it "return error message" do
				user = FactoryGirl.create(:user)
				post :create, { session: { email: user.email, password: "#{user.password}." } }
				expect(flash[:danger]).to_not be_nil
			end

		end

		context "with valid params" do

			it "authenticates user" do
				user = FactoryGirl.create(:user)
				post :create, { session: { email: user.email, password: user.password } }
				expect(session[:user_id]).to eq(user.id)
			end

		end

	end

	describe "DELETE #destroy" do

		context "when user is authenticated" do

			it "destroys user session" do
				user = FactoryGirl.create(:user)
				post :create, { session: { email: user.email, password: user.password } }
				delete :destroy
				expect(session[:user_id]).to be_nil
			end

		end

	end

end