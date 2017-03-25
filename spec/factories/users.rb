FactoryGirl.define do

	factory :user do
		sequence(:name) { |n| "User #{n}" }
		sequence(:email) { |n| "user#{n}@email.com" }
		password "pass"
		password_confirmation "pass"
		admin false
	end

end
